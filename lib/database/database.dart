import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/models/user.dart';

abstract class Database {
  Future<List<Product>> readProducts(String path);
  Stream<List<Product>> getSuggestions(String query);
  Future<String> saveOrder(Order order);
  Stream<List<Order>> getHistory();
  Future<void> updateUser(Users user);
  Future<void> cancelOrder({String orderId});
  // ignore: non_constant_identifier_names
  Stream<Order> orderTracker(String order_id);
  Future<void> saveUser({Users user});
}
