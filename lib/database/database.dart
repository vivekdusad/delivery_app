import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/models/order.dart';

import 'package:delivery_app/models/user.dart';

abstract class Database {
  Stream<List<Product>> readProducts(String path);
  Stream<List<Product>> getSuggestions(String query);
  Future<String> saveOrder(Order order);
  Stream<List<Order>> getHistory();
  Future<void> updateUser(User user);
  // ignore: non_constant_identifier_names
  Stream<Order> orderTracker(String order_id);
  Future<bool> updateFavorites({String productID});
  Future<List<Product>> getFavorites();
}
