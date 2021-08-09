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
                          return ListTile(
                            title: Text(snapshot.data[index].date),
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
