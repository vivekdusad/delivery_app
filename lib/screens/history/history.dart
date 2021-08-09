import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/screens/history/bloc/history_bloc.dart';
import 'package:delivery_app/screens/history/emptyScreen.dart';
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
        body: BlocBuilder<HistoryBloc, HistoryState>(
      bloc: historybloc,
      builder: (context, state) {
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
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 8,
                          child: ListTile(
                            leading: CachedNetworkImage(
                              height: 200,
                              imageUrl: snapshot.data[index].items[0].image_url,
                            ),
                            title: Text(
                              snapshot.data[index].date,
                              style: TextStyle(fontSize: 10),
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
  const ReadyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "Active",
          style: TextStyle(color: Colors.green),
        ),
      ),
      color: Colors.green[300],
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
