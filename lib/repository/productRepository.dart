import 'package:dio/dio.dart';

import '../model/productModel.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Products>> fetchProducts() async {
    final response = await _dio.get('https://dummyjson.com/products');
    final List<dynamic> data = response.data["products"];
    print("response.....$data");
    return data.map((json) => Products.fromJson(json)).toList();
  }

  Future<Products> fetchProductDetails(String productId) async {
    final response =
        await _dio.get('https://dummyjson.com/products/$productId');
    return Products.fromJson(response.data);
  }
}
