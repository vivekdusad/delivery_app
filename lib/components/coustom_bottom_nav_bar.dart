import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constants.dart';
import '../constants/enums.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: currentIndex == 0
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      curve: Curves.easeIn,
                      duration: Duration(
                        milliseconds: 200,
                      ),
                    );
                  }),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Search Icon.svg",
                  color: currentIndex == 1
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      curve: Curves.easeIn,
                      duration: Duration(
                        milliseconds: 200,
                      ),
                    );
                  }
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  color: currentIndex == 2
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                    setState(() {
                      currentIndex = 2;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      curve: Curves.easeIn,
                      duration: Duration(
                        milliseconds: 200,
                      ),
                    );
                  }
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: currentIndex == 3
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      curve: Curves.easeIn,
                      duration: Duration(
                        milliseconds: 200,
                      ),
                    );
                  }
              ),
            ],
          )),
    );
  }
}
