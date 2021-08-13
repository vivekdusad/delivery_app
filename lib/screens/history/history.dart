import 'package:delivery_app/components/error_widget.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/screens/history/bloc/history_bloc.dart';
import 'package:delivery_app/screens/history/emptyScreen.dart';
import 'package:delivery_app/screens/order_details/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({Key key}) : super(key: key);
  static String routeName = "/history";

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final historybloc = watch(historyProvider);
    historybloc.add(GetHistory());
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          bloc: historybloc,
          builder: (context, state) {
            if (state is HistoryErrorOccured) {
              return CustomErrorWidget(
                exception: state.e,
              );
            }
            if (state is HistoryLoaded) {
              return StreamBuilder<List<Order>>(
                stream: state.orders,
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return EmptyScreen();
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final list = snapshot.data;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailsPage(
                                            order: list[index],
                                          )));
                            },
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Order Id: " +
                                              snapshot.data[index].order_id,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total: " +
                                                  snapshot.data[index].total,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(Icons.arrow_forward)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data[index].date,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            ReadyWidget(
                                              track: list[index].track,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
            return EmptyScreen();
          },
        ));
  }
}

class ReadyWidget extends StatelessWidget {
  final String track;
  ReadyWidget({Key key, this.track}) : super(key: key);

  final Map<String, String> map = {
    "${tracks.preparing}": "In progress",
    "${tracks.ready}": "ready",
    "${tracks.outfordelivery}": "Out For Delivery",
    "${tracks.cancelled}": "Cancelled",
  };

  @override
  Widget build(BuildContext context) {
    return Text(
      map[track],
      style: TextStyle(
          color: map[track] == "Cancelled" ? Colors.red : Colors.green,
          fontSize: 15),
    );
  }
}

class ComplettedWidget extends StatelessWidget {
  const ComplettedWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: Text(
        "Completted",
        style: TextStyle(color: Colors.green),
      ),
      color: Colors.green[300],
    );
  }
}
