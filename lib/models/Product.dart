import 'package:flutter/material.dart';

class Product {
  double averageRating, price;
  String id;
  String name,
      category,
      subCategory,
      reference,
      brand,
      description,
      features,
      linkVideo,
      pdfUrl;
  List<String> images;
  List<Color> colors;
  bool isPopular;
  int availability;

  Product({
    required this.availability,
    required this.averageRating,
    required this.price,
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.reference,
    required this.brand,
    required this.description,
    required this.features,
    required this.linkVideo,
    required this.pdfUrl,
    required this.images,
    required this.colors,
    required this.isPopular,
  });

  factory Product.fromJson(
      Map<String, dynamic> productData, String id, List<String> imageUrls) {
    return Product(
      id: id,
      category: productData['category'] ?? "",
      subCategory: productData['subCategory'] ?? "",
      reference: productData['reference'] ?? "",
      brand: productData['brand'] ?? "",
      features: productData['features'] ?? "",
      linkVideo: productData['linkVideo'] ?? "",
      pdfUrl: productData['pdfUrl'] ?? "",
      availability: productData['availability'] ?? 0,
      name: productData['name'] ?? "Wireless Headset",
      price: double.parse(productData['price'] ?? "65.0"),
      description: productData['description'] ?? "This is a description",
      images: imageUrls,
      colors: productData['colors'] != null
          ? List<Color>.from(productData['colors']
              .map((colorString) => parseColor(colorString))
              .toList())
          : [
              Color(0xFFF6625E),
              Colors.black,
              Colors.white,
            ],
      averageRating: double.parse(productData['averageRating'] ?? "0.0"),
      isPopular: productData['isPopular'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageRating': averageRating,
      'price': price,
      'id': id,
      'name': name,
      'category': category,
      'subCategory': subCategory,
      'reference': reference,
      'brand': brand,
      'description': description,
      'features': features,
      'linkVideo': linkVideo,
      'images': images,
      'pdfUrl': pdfUrl,
      'colors': colors.map((color) => color.value.toRadixString(16)).toList(),
      'isPopular': isPopular,
      'availability': availability,
    };
  }

  factory Product.fromJJson(Map<String, dynamic> json, List<String> imageUrls) {
    return Product(
      id: json['id'],
      // Extract the 'id' from the JSON data
      category: json['category'] ?? "",
      subCategory: json['subCategory'] ?? "",
      reference: json['reference'] ?? "",
      brand: json['brand'] ?? "",
      features: json['features'] ?? "",
      linkVideo: json['linkVideo'] ?? "",
      pdfUrl: json['pdfUrl'] ?? "",
      availability: json['availability'] ?? 0,
      name: json['name'] ?? "Wireless Headset",
      price: json['price'] ?? 65.0,
      description: json['description'] ?? "This is a description",
      images: imageUrls,
      colors: json['colors'] != null
          ? List<Color>.from(json['colors']
              .map((colorString) => parseColor(colorString))
              .toList())
          : [
              Color(0xFFF6625E),
              Colors.black,
              Colors.white,
            ],
      averageRating: json['averageRating'] ?? 0.0,
      isPopular: json['isPopular'] ?? true,
    );
  }

  static Color parseColor(String colorString) {
    if (colorString.startsWith('Color(')) {
      final hexCode =
          colorString.replaceAll("Color(", "").replaceAll(")", "").substring(2);
      return Color(int.parse(hexCode, radix: 16) + 0xFF000000);
    } else if (colorString == 'Colors.white') {
      return Colors.white;
    }
    // Add more cases here if needed for other color strings
    return Colors.black; // Default color if the input string is not recognized
  }
}
