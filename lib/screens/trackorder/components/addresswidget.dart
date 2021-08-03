import 'package:flutter/material.dart';



class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.home,
            size: 30.0,
          ),
          SizedBox(width: 32.0),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Home, Work & Other Address",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    "House No: 1234, 2nd Floor Sector 18, Silicon Valey Amerika Serikat",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}