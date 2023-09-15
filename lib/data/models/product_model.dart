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

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      name: json['title'],
      detail: json['description'],
      price: json['price'],
      image: json['thumbnail'],
    );
  }
}
