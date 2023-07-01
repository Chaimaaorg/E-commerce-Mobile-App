import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Product.dart';

class ProductController {
  static final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection('Products');
  static final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('Users');
  static final FirebaseStorage storage = FirebaseStorage.instance;

  final Map<String, List<String>> productImagesCache = {};
  final List<Product> cachedProducts = [];

  // Constructor for the class
  ProductController();

  Future<void> fetchAllProductsAndImages() async {
    try {
      QuerySnapshot snapshot = await productsCollection.get();
      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnapshot in snapshot.docs) {
          Map<String, dynamic> productData =
          docSnapshot.data() as Map<String, dynamic>;
          List<String> imageUrls = productImagesCache[docSnapshot.id] ??
              await getProductImages(docSnapshot.id);
          productImagesCache[docSnapshot.id] = imageUrls;
          cachedProducts
              .add(Product.fromJson(productData, docSnapshot.id, imageUrls));
        }
      }
    } catch (e) {
      print("Error fetching all products and images: $e");
    }
  }

  Future<List<Product>> getAllProducts() async {
    await fetchAllProductsAndImages();
    return cachedProducts;
  }

  Stream<List<Product>> getAllProductsStream() {
    return productsCollection.snapshots().asyncMap((snapshot) async {
      final productFutures = snapshot.docs.map((doc) async {
        Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
        List<String> imageUrls = await getProductImages(doc.id);
        return Product.fromJson(productData, doc.id, imageUrls);
      });

      return Future.wait(productFutures);
    });
  }

  Future<List<String>> getProductImages(String productId) async {
    try {
      Reference storageRef = storage.ref().child('images/$productId');
      ListResult result = await storageRef.listAll();

      final imageUrls = await Future.wait(result.items.map((ref) async {
        return ref.getDownloadURL();
      }).toList());

      return imageUrls;
    } catch (e) {
      print("Error getting product images: $e");
      return [];
    }
  }
  Future<List<Product?>> getUsersFavProducts(String userId) async {
    List<Product?> favoriteProducts = [];
    try {
      DocumentSnapshot userDataSnapshot = await usersCollection.doc(userId).get();
      if (userDataSnapshot.exists) {
        List<dynamic>? favoriteProductIds =
        List<String>.from(userDataSnapshot.get('favouriteProducts') ?? []);
        if (favoriteProductIds.isNotEmpty) {
          favoriteProducts = await Future.wait(favoriteProductIds
              .map((productId) async => getProductById(productId)));
        }
      }
    } catch (e) {
      print("Error getting favorite products for user: $e");
    }
    return favoriteProducts;
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    List<Product> products = [];

    try {
      QuerySnapshot snapshot =
      await productsCollection.where('category', isEqualTo: category).get();

      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnapshot in snapshot.docs) {
          Map<String, dynamic> productData =
          docSnapshot.data() as Map<String, dynamic>;
          // Fetch images using product ID
          List<String> imageUrls = await getProductImages(docSnapshot.id);
          products
              .add(Product.fromJson(productData, docSnapshot.id, imageUrls));
        }
      }
    } catch (e) {
      print("Error fetching products by category: $e");
    }

    return products;
  }


  // Updated getProductById method to use cachedProducts
  Future<Product?> getProductById(String id) async {
    await fetchAllProductsAndImages();
    return cachedProducts.firstWhere((product) => product.id == id);
  }

  Future<void> updateProductRating(String productId, double newRating) async {
    try {
      await productsCollection
          .doc(productId)
          .update({'averageRating': newRating.toString()});
    } catch (e) {
      print("Error updating product rating: $e");
    }
  }

  static Future<bool> toggleFavorite(String productId, bool isFavourite) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not authenticated, handle the error appropriately
        throw Exception("User not authenticated.");
      }
      final userDocRef = usersCollection.doc(currentUser.uid);
      // Get the user's document to access the 'favouriteProducts' field
      final userDataSnapshot = await userDocRef.get();

      final List<String> favouriteProducts =
      List<String>.from(userDataSnapshot['favouriteProducts'] ?? []);

      if (favouriteProducts.contains(productId)) {
        // If the productId exists in the 'favouriteProducts' list, remove it
        favouriteProducts.remove(productId);
      } else {
        // If the productId doesn't exist in the 'favouriteProducts' list, add it
        favouriteProducts.add(productId);
      }

      // Update the 'favouriteProducts' field in the user's document
      await userDocRef.set(
        {'favouriteProducts': favouriteProducts},
        SetOptions(merge: true),
      );

      // Return the updated value of isFavourite
      return !isFavourite;
    } catch (e) {
      print("Error updating product: $e");
      // Return the original value if update fails
      return isFavourite;
    }
  }

  static Future<bool> isProductFavorite(String productId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not authenticated, handle the error appropriately
        throw Exception("User not authenticated.");
      }
      final userDocRef = usersCollection.doc(currentUser.uid);
      // Get the user's document to access the 'favouriteProducts' field
      final userDataSnapshot = await userDocRef.get();

      final List<String> favouriteProducts =
      List<String>.from(userDataSnapshot['favouriteProducts'] ?? []);

      // Check if the productId exists in the 'favouriteProducts' list
      return favouriteProducts.contains(productId);
    } catch (e) {
      print("Error checking product favorite status: $e");
      return false;
    }
  }
}
