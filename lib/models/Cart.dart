import 'package:delivery_app/models/product.dart';
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
      totalsum = totalsum + int.parse(key.price) * value;
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
      if (products[product] == 1) {
        products.remove(product);
      } else {
        products[product] -= 1;
      }
      notifyListeners();
    }
  }

  void emptyCart() {
    products = {};
    notifyListeners();
  }
}
