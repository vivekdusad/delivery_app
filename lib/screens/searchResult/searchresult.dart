import 'package:delivery_app/components/error_widget.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/results/bloc/results_bloc.dart';
import 'package:delivery_app/screens/searchResult/body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultPage extends StatelessWidget {
  final String query;
  const SearchResultPage({Key key, this.query}) : super(key: key);
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      var resultBloc = ResultsBloc(watch(databaseProvider));
      resultBloc.add(SearchResultLoad(query: query));
      return BlocProvider(
        create: (context) => resultBloc,
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<ResultsBloc, ResultsState>(
            builder: (context, state) {
              if (state is ResultsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ResultsLoadedStream) {
                return Body(product: state.products);
              } else if (state is ResultsErrorOccured) {
                return CustomErrorWidget(
                  exception: state.exception,
                );
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
