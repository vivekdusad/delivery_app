import 'package:delivery_app/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../constants/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30, context)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(20, context)),
            SearchWidget(),
            SizedBox(height: getProportionateScreenHeight(20, context)),
            CallNowWidget(),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30, context)),
            PopularProducts(),
            // SizedBox(height: getProportionateScreenWidth(30, context)),
            Container(
              // height: 90,
              width: double.infinity,
              margin: EdgeInsets.all(getProportionateScreenWidth(20, context)),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20, context),
                vertical: getProportionateScreenWidth(15, context),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF4A3298),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "upto 20% Discount\n",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(24, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: "From MRP"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CallNowWidget extends StatelessWidget {
  const CallNowWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          width: double.infinity,
          color: Color(0xFFF2F2F2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    width: getProportionateScreenWidth(220, context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Call by Order"),
                        Text(
                            "Call our team to directly order. We do the rest!"),
                      ],
                    )),
              ),
              FlatButton(
                  color: Colors.red[200],
                  onPressed: () async {
                    await _callNumber();
                  },
                  child: Text("Call Now"))
            ],
          ),
        ),
        Container(
          height: 10,
          width: double.infinity,
          color: Color(0xFFF2F2F2),
        ),
      ],
    );
  }

  Future<void> _callNumber() async {
    const number = '+918302135675'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10, context)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Search",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
