import 'package:delivery_app/models/Product.dart';
import 'package:flutter/widgets.dart';

class Cart extends ChangeNotifier {
  List<Product> products = [];
  List<Product> get getProducts => products;
  double get total {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + double.parse(nextProduct.price);
    });
  }

  void addToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (products.contains(product)) {
      products.remove(product);
      notifyListeners();
    }
  }

  void emptyList() {
    products = [];
    notifyListeners();
  }
}
