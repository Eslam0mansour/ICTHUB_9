import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:icthubx/data/models/product_model.dart';

class DataSource {
  static Future<List<ProductData>> getData() async {
    List<ProductData> dataA = [];
    try {
      final res = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(res.body);

        for (var item in responseData['products']) {
          ProductData object1 = ProductData.fromJson(item);
          dataA.add(object1);
        }
      }
      return dataA;
    } catch (e) {
      print(e);
      return dataA;
    }
  }

  static List<ProductData> myList = [];
}
