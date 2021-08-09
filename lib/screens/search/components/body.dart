import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/screens/search/bloc/search_bloc.dart';
import 'package:delivery_app/screens/search/search_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final bloc = ProviderContainer().read(searchblocprovider);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      backdropColor: Colors.white,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        print(query);
        if (query.isNotEmpty) {
          bloc.add(SearchRequested(query: query));
        }
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return BlocBuilder<SearchBloc, SearchState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SearchLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SearchLoaded) {
              return Container(
                height: 400,
                width: 400,
                child: StreamBuilder<List<Product>>(
                    stream: state.products,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return EmptySearch();
                        }
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            final quote = snapshot.data[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCard(product: quote),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
