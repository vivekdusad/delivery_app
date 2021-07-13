import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/screens/results/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Cleansres",
        "path": ApiPath.cleansers
      },
      {
        "icon": "assets/icons/Bill Icon.svg",
        "text": "Kitchen Essentials",
        "path": ApiPath.kitchen
      },
      {
        "icon": "assets/icons/Game Icon.svg",
        "text": "Bath Essentials",
        "path": ApiPath.bath
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Skin Care",
        "path": ApiPath.skin
      },
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20,context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            path: categories[index]["path"],
                          )));
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(60,context),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15,context)),
              height: getProportionateScreenWidth(55,context),
              width: getProportionateScreenWidth(55,context),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
