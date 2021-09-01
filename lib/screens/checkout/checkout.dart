import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/constants/theme.dart';

import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/models/user.dart';
import 'package:delivery_app/screens/changeAddress/changeAddress.dart';
import 'package:delivery_app/screens/checkout/bloc/checkout_bloc.dart';
import 'package:delivery_app/screens/checkout/components/paymentcard/confirmOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/paymentcard/paymentcard.dart';

class CheckoutScreen extends ConsumerWidget {
  static const routeName = "/checkoutScreen";

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var sum = watch(cartProvider).total;
    Random rnd = new Random();
    int min = 1000;
    int max = 9999;
    final checkoutBloc = watch(checkoutblocProvider);
    return WillPopScope(
      onWillPop: () async {
        bool cancel = false;
        AlertDialog alertDialog = AlertDialog(
          content: Text("Cancel Order"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No")),
            TextButton(
                onPressed: () {
                  cancel = true;
                  Navigator.pop(context);
                },
                child: Text("Cancel It")),
          ],
        );
        await showDialog(context: context, builder: (context) => alertDialog);
        return cancel;
      },
      child: BlocProvider(
        create: (context) => checkoutBloc,
        child: Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Checkout",
                              style: getTheme(context).headline5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Delivery Address"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WatchBoxBuilder(
                              box: Hive.box('user'),
                              builder: (context, box) {
                                final user = box.get('user') as Users;
                                return SizedBox(
                                  width:
                                      getProportionateScreenWidth(200, context),
                                  child: Text(
                                    user.address,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                  ),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeAddressScreen()));
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Color(0xFFF2F2F2),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment method"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PaymentCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cash on delivery",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(color: Color(0xFFFC6011)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Color(0xFFF2F2F2),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sub Total"),
                                Text(
                                  "\₹",
                                  style: getTheme(context).headline6,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Cost"),
                                Text(
                                  "\₹10",
                                  style: getTheme(context).headline6,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Discount"),
                                Text(
                                  "-\₹4",
                                  style: getTheme(context).headline6,
                                )
                              ],
                            ),
                            Divider(
                              height: 40,
                              color: Color(0xFFB6B7B7).withOpacity(0.25),
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total"),
                                Text(
                                  "₹${sum + 6}",
                                  style: getTheme(context).headline3,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Color(0xFFF2F2F2),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: BlocListener<CheckoutBloc, CheckoutState>(
                            listener: (context, state) {
                              if (state is OrderSaved) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmOrder(
                                              order_id: state.order_id,
                                            )));
                              }
                            },
                            child: BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                print(state);
                                if (state is OrderSaving) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return DefaultButton(
                                  press: () async {
                                    var position =
                                        await Geolocator.getCurrentPosition();
                                    var uid =
                                        FirebaseAuth.instance.currentUser.uid;

                                    var token = await FirebaseMessaging.instance
                                        .getToken();
                                    final user = await ProviderContainer()
                                        .read(localStorageProvider)
                                        .getUserFromStorage();
                                    checkoutBloc.add(SaveOrder(
                                        order: Order(
                                            lat: position.latitude.toString(),
                                            long: position.longitude.toString(),
                                            token: token,
                                            track: "${tracks.preparing}",
                                            user_id: uid,
                                            date: Timestamp.now(),
                                            total: (sum + 6).toString(),
                                            name: user.name,
                                            address: user.address,
                                            counts: watch(cartProvider)
                                                .getProducts
                                                .values
                                                .toList(),
                                            items: watch(cartProvider)
                                                .getProducts
                                                .keys
                                                .toList(),
                                            code:
                                                "${min + rnd.nextInt(max - min)}",
                                            phone: user.phone,
                                            order_id: '')));
                                    watch(cartProvider).emptyCart();
                                  },
                                  text: "Send Order",
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
