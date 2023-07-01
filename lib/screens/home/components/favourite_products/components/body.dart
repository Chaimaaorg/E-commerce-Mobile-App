import 'package:Districap/screens/home/components/favourite_products/components/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../controllers/product_controller.dart';
import '../../../../../models/Product.dart';
import '../../../../../models/Categories.dart' as MyCategories;
import '../../../../../providers/product_search_state.dart';
import 'details/details_screen.dart';
import 'itemCard.dart';

class Body extends StatefulWidget {
  final ProductSearchState searchPro;

  Body({required this.searchPro});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedCategory = "Accessories";
  bool isLoading = false;
  final List<Product?> products = [];
  int selectedIndex = 0; // Initialize selectedIndex to 0

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    ProductController productController = ProductController();
    List<Product?> productss = await productController.getUsersFavProducts(FirebaseAuth.instance.currentUser!.uid);

    // Apply search filtering if a search query is present
    String searchQuery = widget.searchPro.searchQuery.toLowerCase();
    List<Product?> filteredProducts = productss;

    if (searchQuery.isNotEmpty) {
      filteredProducts = productss
          .where((product) =>
      product?.name.toLowerCase().contains(searchQuery) ?? false)
          .toList();
    }

    setState(() {
      selectedCategory = searchQuery.isNotEmpty
          ? filteredProducts[0]!.category
          : "Accessories";
      products.clear();
      products.addAll(filteredProducts);
      isLoading =
      false; // You might need to adjust this based on your use case.
      selectedIndex = MyCategories.Categories.getAllCategories()
          .indexOf(selectedCategory); // Update the selectedIndex
    });
  }

  String getSelectedCategoryForSearchQuery(
      String searchQuery, List<Product?> products) {
    for (Product? prod in products) {
      if (prod!.category.toLowerCase().contains(searchQuery)) {
        return prod.category;
      }
    }
    return "Accessories"; // Default value if no matching category is found.
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Favourite products",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
            selectedCategory: selectedCategory, // Pass the selected category
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getFavProduct(
                  selectedCategory, widget.searchPro.searchQuery)
                  .length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPaddin,
                crossAxisSpacing: kDefaultPaddin,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: getFavProduct(selectedCategory,
                    widget.searchPro.searchQuery)[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      product: getFavProduct(selectedCategory,
                          widget.searchPro.searchQuery)[index],
                      // isFavourite: _isFavorite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product?> getFavProduct(String category, String searchQuery) {
    List<Product?> listaFav = [];
    Product? prod;
    for (prod in products) {
      if (prod!.category == category &&
          (searchQuery.isEmpty ||
              prod.name.toLowerCase().contains(searchQuery.toLowerCase()))) {
        listaFav.add(prod);
      }
    }
    return listaFav;
  }
}