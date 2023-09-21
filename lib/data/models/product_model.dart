import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String name;
  String detail;
  String image;
  int price;

  ProductData({
    required this.name,
    required this.detail,
    required this.price,
    required this.image,
  });

  factory ProductData.formDocs(DocumentSnapshot<Map<String, dynamic>> docs) {
    return ProductData(
      name: docs['title'],
      detail: docs['description'],
      price: docs['price'],
      image: docs['thumbnail'],
    );
  }
}
