import 'package:cloud_firestore/cloud_firestore.dart';

import 'Product.dart';

class Promotion {
  String? id;
  String? productId;
  String? productName;
  String? productImage;
  String? type;
  String? discount;
  DateTime? startDate;
  DateTime? endDate;

  Promotion({
    this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.type,
    this.discount,
    this.startDate,
    this.endDate,
  });

  // Create a Promotion object from a JSON map
  factory Promotion.fromJson(Map<String, dynamic> json, Product product) {
    return Promotion(
      id: json['id'],
      productId: json['prodId'],
      productName: product.name,
      productImage: product.images[0],
      type: json['type'],
      discount: json['discount'],
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
    );
  }

  // Convert a Promotion object to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['prodId'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['start_date'] = this.startDate?.toIso8601String();
    data['end_date'] = this.endDate?.toIso8601String();
    return data;
  }

}
