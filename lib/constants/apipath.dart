class ApiPath {
  static String users(String uid) => "users";
  static String products = "products";
  static String favorite(String uid) => "favorite/$uid";
  static String orders(String uid) => "orders/$uid/orders";
  static String ordersadmin(String uid) => "orders/$uid/orders";
}
