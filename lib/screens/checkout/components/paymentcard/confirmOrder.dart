import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/constants/theme.dart';
import 'package:delivery_app/screens/home/home_screen.dart';
import 'package:delivery_app/screens/trackorder/trackorder.dart';
import 'package:flutter/material.dart';

class ConfirmOrder extends StatelessWidget {
  final String order_id;
  const ConfirmOrder({Key key,@required this.order_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: Container(
        height: getScreenHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thank You!",
              style: TextStyle(
                color: Color(0xFF4A4B4D),
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "for your order",
              style: getTheme(context)
                  .headline4
                  .copyWith(color: Color(0xFF4A4B4D)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                  "Your order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your order"),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TrackOrder(order_id: order_id,)));
                  },
                  child: Text("Track My Order"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                },
                child: Text(
                  "Back To Home",
                  style: TextStyle(
                    color: Color(0xFF4A4B4D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
