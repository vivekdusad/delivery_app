import 'package:delivery_app/components/coustom_bottom_nav_bar.dart';
import 'package:delivery_app/constants/enums.dart';
import 'package:delivery_app/constants/provider.dart';
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
    return Scaffold(
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.history),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          bloc: watch(historyProvider),
          builder: (context, state) {
            return EmptyScreen();
          },
        ));
  }
}
