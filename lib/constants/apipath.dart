class ApiPath {
  static String cleansers = "cleansers";
  static String kitchen = "Kitchen Essentials";
  static String bath = "Bath Essentials";
  static String skin = "Self Care";
  static String users(String uid) => "users/$uid";
  static String products = "products";
  static String orders(String uid) => "users/$uid/orders";
}
