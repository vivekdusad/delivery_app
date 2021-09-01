import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/components/product_card.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class ResultsPage extends StatefulWidget {
  final String path;
  ResultsPage({Key key, this.path}) : super(key: key);
  static String routeName = "/results";

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  ScrollController _controller;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  bool _show = false;
  double bottomBarHeight = 75;
  double _bottomBarOffset = 0;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      myScroll();
    });
    super.initState();
  }

  void myScroll() async {
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.path);
    return Consumer(builder: (context, watch, child) {
      return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: _show
            ? FloatingNavbar(
                backgroundColor: kPrimaryColor,
                onTap: (int val) {},
                currentIndex: 0,
                items: [
                  FloatingNavbarItem(icon: Icons.sort, title: 'Sort'),
                  FloatingNavbarItem(icon: Icons.filter, title: 'Filter'),
                ],
              )
            : SizedBox(),
        body: Column(
          children: [
            SearchWidget(),
            CallNowWidget(),
            Expanded(
              child: PaginateFirestore(
                scrollController: _controller,
                itemBuilder: (index, context, documentSnapshot) {
                  final data = documentSnapshot.data() as Map;
                  final product = Product.fromMap(data);
                  return ProductCard(product: product);
                },
                query: FirebaseFirestore.instance
                    .collection(ApiPath.products)
                    .where('category', isEqualTo: widget.path)
                    .orderBy('name'),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
              ),
            ),
          ],
        ),
      );
    });
  }
}
