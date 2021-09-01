import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/components/loading_widget.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/screens/order_details/bloc/orderdetails_bloc.dart';
import 'package:delivery_app/screens/order_details/components/header.dart';
import 'package:delivery_app/screens/order_details/components/items_section.dart';
import 'package:delivery_app/screens/trackorder/trackorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;

  const OrderDetailsPage({Key key, this.order}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderdetailsBloc(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(
                    order: widget.order,
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Color(0xFFF2F2F2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ItemsSection(
                    order: widget.order,
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
                  if (widget.order.track == "${tracks.comletted}" ||
                      widget.order.track != "${tracks.cancelled}")
                    DefaultButton(
                      text: "Track Order",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackOrder(
                                    order_id: widget.order.order_id)));
                      },
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer(builder: (context, watch, child) {
                    final bloc = watch(orderdetailblocprovider);
                    return BlocBuilder<OrderdetailsBloc, OrderdetailsState>(
                      builder: (context, state) {
                        if (state is OrderCancelling) {
                          return CustomLoadingWidget();
                        }
                        if (state is OrderCancelled) {
                          return AlreadyCancelled();
                        }
                        return widget.order.track != "${tracks.cancelled}"
                            ? DefaultButton(
                                color: Colors.red,
                                text: "Cancel Order",
                                textColor: Colors.white,
                                press: () async {
                                  AlertDialog alertDialog = AlertDialog(
                                    content: Text("Are You Sure"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("No")),
                                      TextButton(
                                          onPressed: () {
                                            bloc.add(CancelOrder(
                                                orderId:
                                                    widget.order.order_id));
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes")),
                                    ],
                                  );
                                  await showDialog(
                                      context: context,
                                      builder: (context) => alertDialog);
                                },
                              )
                            : AlreadyCancelled();
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlreadyCancelled extends StatelessWidget {
  const AlreadyCancelled({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Container(
          color: Colors.red[400],
          child: Center(
              child: Text(
            "Cancelled",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
