import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/models/order.dart';

abstract class Database { 
  
  Stream<List<Product>> readProducts(String path);  
  Stream<List<Product>> getSuggestions(String query);
  Future<void> saveOrder(Order order);  
}
