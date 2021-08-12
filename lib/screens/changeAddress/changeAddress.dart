import 'package:delivery_app/components/default_button.dart';
import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key key}) : super(key: key);

  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  TextEditingController _addresController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(10, context)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/address.svg",
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10, context),
                  ),
                  Text("Manually Type your address or tap on Location Button"),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: _addresController,
                        decoration: InputDecoration(hintText: "Enter Address"),
                      )),
                      Container(
                        height: 100,
                        width: 100,
                        child: IconButton(
                            color: kPrimaryColor,
                            onPressed: () async {
                              Position position = await _determinePosition();
                              print(position.latitude);
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      position.latitude, position.longitude);
                              final address =
                                  '${placemarks[0].locality},${placemarks[0].administrativeArea},${placemarks[0].subLocality},${placemarks[0].subAdministrativeArea},';

                              setState(() {
                                _addresController.text = address;
                              });
                            },
                            icon: SvgPicture.asset(
                                "assets/icons/Location point.svg")),
                      ),
                    ],
                  ),
                  DefaultButton(
                    text: "Save Address",
                    press: () async {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
