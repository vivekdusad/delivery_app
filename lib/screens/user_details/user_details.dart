import 'package:delivery_app/constants/constants.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/screens/user_details/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EditProfilePage();
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final detailsbloc = watch(detailsblocProvider);
        detailsbloc.add(DetailsPageOpened());

        return Scaffold(
          appBar: AppBar(),
          body: BlocListener<DetailsBloc, DetailsState>(
            bloc: detailsbloc,
            listener: (context, state) {
              if (state is DetailsSaved) {
                EasyLoading.dismiss();
                Navigator.pop(context);
              } else if (state is DetailsSaving) {
                EasyLoading.show(status: 'Saving');
              }
            },
            child: BlocBuilder<DetailsBloc, DetailsState>(
              bloc: detailsbloc,
              builder: (context, state) {
                if (state is DetailsOpened) {
                  _nameController.text = state.user.name;
                  _phoneController.text = state.user.phone;
                  _addressController.text = state.user.address;
                  return Container(
                    padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: ListView(
                        children: [
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextField(
                            "Name",
                            _nameController,
                          ),
                          buildTextField(
                            "Phone",
                            _phoneController,
                          ),
                          buildTextField(
                            "Adress",
                            _addressController,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlineButton(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("CANCEL",
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.black)),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  final currentUser = ProviderContainer()
                                      .read(currentUserprovider);
                                  final user = currentUser.currentUser.copyWith(
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    address: _addressController.text,
                                  );
                                  print(_phoneController.text);
                                  detailsbloc.add(UpdateDetails(user));
                                },
                                color: kPrimaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        initialValue: controller.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
