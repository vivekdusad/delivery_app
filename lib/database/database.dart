
import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/models/user.dart';

abstract class Database {
  Stream<List<Product>> readProducts(String path);
  Stream<List<Product>> getSuggestions(String query);
  Future<void> saveOrder(Order order);
  Future<Stream<List<Order>>> getHistory();
  Future<void> updateUser(User user);
  Future<bool> updateFavorites({String productID});
  Future<List<Product>> getFavorites();
}
