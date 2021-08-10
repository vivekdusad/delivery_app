import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'components/addresswidget.dart';
import 'components/datewidget.dart';
import 'components/orderidwidget.dart';

class TrackOrder extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String order_id;
  // ignore: non_constant_identifier_names
  TrackOrder({Key key, @required this.order_id}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  // ignore: non_constant_identifier_names
  Stream<Order> orderTracker(String order_id) {
    print(order_id);
    final document = FirebaseFirestore.instance
        .collection(ApiPath.orders(FirebaseAuth.instance.currentUser.uid))
        .doc(order_id);
    final data = document.snapshots();
    return data.map((event) => Order.fromMap(event.data()));
  }

  @override
  Widget build(BuildContext context) {
    List<String> track = [
      "Order Placed",
      "Ready",
      "Out For Delivery",
      "Delivered"
    ];
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Order>(
          stream: orderTracker(widget.order_id),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.yellow,
              ));
            } else if (snapshot.hasData ||
                snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateWidget(),
                  OrderIdWidget(widget: widget),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                    ),
                    child: Text(
                      "Tracks",
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 6,
                        child: IconStepper(
                          direction: Axis.vertical,
                          enableNextPreviousButtons: false,
                          enableStepTapping: false,
                          stepColor: kPrimaryColor,
                          activeStepBorderWidth: 0.0,
                          activeStepBorderPadding: 0.0,
                          lineColor: kPrimaryColor,
                          lineLength: 70.0,
                          lineDotRadius: 2.0,
                          stepRadius: 16.0,
                          icons: [
                            Icon(Icons.radio_button_checked,
                                color: Colors.white),
                            Icon(Icons.check,
                                color: data.track == "${tracks.ready}"
                                    ? Colors.white
                                    : kPrimaryColor),
                            Icon(Icons.check,
                                color: data.track == "${tracks.outfordelivery}"
                                    ? Colors.white
                                    : kPrimaryColor),
                            Icon(Icons.check,
                                color: data.track == "${tracks.comletted}"
                                    ? Colors.white
                                    : kPrimaryColor),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    title: Text(
                                      track[index],
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    subtitle: Text(
                                      "We are Preparing your order",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  AddressWidget(),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
