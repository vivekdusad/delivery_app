
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/results/bloc/results_bloc.dart';
import 'package:delivery_app/screens/results/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultsPage extends StatelessWidget {
  final String path;
  const ResultsPage({Key key, this.path}) : super(key: key);
  static String routeName = "/results";

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      var resultBloc = ResultsBloc(watch(databaseProvider));
      resultBloc.add(ResultLoad(category: path));
      return BlocProvider(
        create: (context) => resultBloc,
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<ResultsBloc, ResultsState>(
            builder: (context, state) {
              if (state is ResultsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ResultsLoaded) {
                return Body(product: state.products);
              } else if (state is ResultsErrorOccured) {
                return Center(child: Text(state.message));
              }
              return Container(
                color: Colors.red,
              );
            },
          ),
        ),
      );
    });
  }
}
