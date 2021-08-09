import 'package:delivery_app/models/Product.dart';
import 'package:flutter/widgets.dart';

class Cart extends ChangeNotifier {
  Map<Product, int> products = {};
  Map<Product, int> get getProducts => products;
  double get total {
    // return products.fold(0.0, (double currentTotal, Product nextProduct) {
    //   return currentTotal + int.parse(nextProduct.price);
    // });
    double totalsum = 0;
    products.forEach((key, value) {
      totalsum = totalsum + int.parse(key.price)*value;
    });
    return totalsum;
  }

  void addToCart(Product product) {
    if (products.containsKey(product)) {
      products[product] += 1;
    } else {
      products[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (products.containsKey(product)) {
      products.remove(product);
      notifyListeners();
    }
  }

  void emptyCart() {
    products = {};
    notifyListeners();
  }
}
