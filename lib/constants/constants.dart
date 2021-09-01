import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/models/product.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}

class Constants {
  static final String firstTime = "firstTime";
}

List<Product> demoProducts = [
  Product(
    id: "1",
    subcategory: "",
    image_url:
        "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/moongkachilka.jpg?alt=media&token=b004a4a6-590f-4901-b610-c60fd4943d7c",
    name: "Mung Daal",
    category: Category.kitchen_essentials,
    price: "250",
    brand: "Surf Excel",
    discount: 15,
    bestSeller: false,
  ),
  Product(
    id: "2",
    image_url:
        "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/surfexcel.jpg?alt=media&token=39962c1c-520d-4f22-a367-9d42878a7036",
    subcategory: "",
    name: "Surf Excel",
    category: Category.Bath_cleansers,
    price: "120",
    brand: "Surf Excel",
    discount: 15,
    bestSeller: true,
  ),
  Product(
    id: "3",
    subcategory: "",
    image_url:
        "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/amchoor-min.jpg?alt=media&token=d2ace3ae-314a-44c1-9786-4646a6043fa8",
    name: "Amchoor",
    category: Category.kitchen_essentials,
    price: "64",
    brand: "catch",
    discount: 15,
    bestSeller: true,
  ),
  Product(
    id: "4",
    image_url:
        "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/rajma.jpg?alt=media&token=fa6820cc-0c59-45fb-8254-b7fdf4800a6d",
    category: Category.kitchen_essentials,
    subcategory: "",
    name: "Rajma",
    price: "50",
    brand: "",
    discount: 15,
    bestSeller: true,
  ),
];
