import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/custom_text_form_field.dart';
import 'package:flutter_driver/res/custom_dropdown_button.dart';
import 'package:flutter_driver/res/custom_datePicker/common_textfield.dart';
import 'package:flutter_driver/res/custom_search_location.dart';
import 'package:flutter_driver/res/login/login_customTextFeild.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditProfiePage extends StatefulWidget {
  final String usrId;
  final String mobileNumber;
  const EditProfiePage(
      {super.key, required this.usrId, required this.mobileNumber});

  @override
  State<EditProfiePage> createState() => _EditProfiePageState();
}

class _EditProfiePageState extends State<EditProfiePage> {
  List<TextEditingController> controlers =
      List.generate(1, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  final String _googleApiKey = 'AIzaSyDhKIUQ4QBoDuOsooDfNY_EjCG0MB7Ami8';

  // 'AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo';
  String? gengerName;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  String phoneNumber = '';
  String isoCode = '';
  String stateCode = '';
  String? cuntryCode;
  String? mobileNumber;
  String profileImg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firstNameController.text = data?.firstName ?? '';
      lastNameController.text = data?.lastName ?? '';
      genderController.text = data?.gender ?? '';
      locationController.text = data?.driverAddress ?? '';
      phoneNumberController.text = widget.mobileNumber;
      countryController.text = data?.country ?? 'United Arab Emirates';
      stateController.text = data?.state ?? '';
      profileImg = data?.profileImageUrl ?? '';
      getCountry();
    });
  }

  getUser() async {
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<DriverProfileViewModel>(context, listen: false)
          .fetchDriverDetailViewModelApi(
              context, {"driverId": widget.usrId}, widget.usrId);
    });
  }

  Dio? dio;
  String accessToken = '';
  void getCountry() async {
    debugPrint(
        'cnmxncmnbx../././././././././.. cmnnb ${countryController.text}');
    try {
      var countryProvider = await Provider.of<GetCountryStateListViewModel>(
          context,
          listen: false);
      countryProvider.getAccessToken(context: context).then((onValue) {
        debugPrint('token,.....c//.c.... $onValue');
        setState(() {
          accessToken = onValue['auth_token'].toString();
        });
        // countryProvider.getCountryList(context: context, token: accessToken);
        Provider.of<GetCountryStateListViewModel>(context, listen: false)
            .getStateList(
                context: context,
                token: accessToken,
                country: countryController.text.isEmpty
                    ? 'United Arab Emirates'
                    : countryController.text);
      });
    } catch (e) {
      debugPrint('error $e');
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  bool loader = false;
  DriverProfileData? data;
  @override
  Widget build(BuildContext context) {
    bool status = context.watch<DriverProfileUpdateViewModel>().isLoading;
    List state =
        context.watch<GetCountryStateListViewModel>().getStateListModel;
    bool isLoadingState =
        context.watch<GetCountryStateListViewModel>().isLoading;
    debugPrint(widget.usrId.toString());
    data = context.watch<DriverProfileViewModel>().DataList.data?.data;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomPagelayout(
        appBarTitle: 'Edit Profile',
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(text: 'First Name', style: titleTextStyle),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: redColor))
                  ])),
                  const SizedBox(height: 5),
                  Customtextformfield(
                    focusNode: focusNode1,
                    controller: firstNameController,
                    prefixiconvisible: true,
                    img: user,
                    hintText: 'First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: 'Last Name', style: titleTextStyle),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: redColor))
                  ])),
                  const SizedBox(height: 5),
                  Customtextformfield(
                    focusNode: focusNode2,
                    controller: lastNameController,
                    prefixiconvisible: true,
                    img: user,
                    hintText: 'Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: 'Gender', style: titleTextStyle),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: redColor))
                  ])),
                  const SizedBox(height: 5),
                  CustomDropdown(
                      controller: genderController,
                      selectedBorderColor: btnColor,
                      prifixIconVisible: true,
                      img: gender,
                      fillColor: background,
                      hintText: 'Select Gender',
                      items: const ['Male', 'Female'],
                      onChanged: (value) {}),
                  const SizedBox(height: 5),
                  CommonTextFeild(
                    width: double.infinity,
                    heading: "Country",
                    headingReq: true,
                    prefixIcon: true,
                    controller:
                        TextEditingController(text: countryController.text),
                    readOnly: true,
                    img: address,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: 'State', style: titleTextStyle),
                        const TextSpan(
                            text: ' *', style: TextStyle(color: redColor))
                      ]))),
                  CustomDropdown(
                      controller: stateController,
                      selectedBorderColor: btnColor,
                      prifixIconVisible: true,
                      img: address,
                      fillColor: background,
                      hintText: 'Select State',
                      items: state.map((state) {
                        return state['state_name'].toString();
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          locationController.clear();
                        });
                      }),
                  const SizedBox(height: 5),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: 'Location', style: titleTextStyle),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: redColor))
                  ])),
                  const SizedBox(height: 5),
                  CustomSearchLocation(
                      fillColor: background,
                      focusNode: focusNode3,
                      controller: locationController,
                      state: stateController.text,
                      hintText: 'Search your location'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtonBig(
                      loading: status,
                      btnHeading: "UPDATE",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<DriverProfileUpdateViewModel>(context,
                                  listen: false)
                              .editProfile(
                            context: context,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            gender: genderController.text,
                            country: countryController.text.isEmpty
                                ? 'United Arab Emirates'
                                : countryController.text,
                            state: stateController.text,
                            location: locationController.text,
                          );
                        }
                        // Map<String, dynamic> data = {
                        //   "driverId": widget.usrId.toString(),
                        //   "countryCode": cuntryCode,
                        //   "mobile": phoneNumberController.text,

                        //   ///Name of Country
                        //   // "countryCode": isoCode.toString(),
                        // };
                        // setState(() {
                        //   debugPrint(data.toString());
                        //   debugPrint(phoneNumberController.toString());
                        //   debugPrint(widget.usrId.toString());
                        // });
                        // if (phoneNumberController.text.isEmpty ||
                        //     phoneNumberController.text.length <= 5) {
                        //   Utils.flushBarErrorMessage(
                        //       "Please enter your number first", context);
                        // } else {
                        //   loader = true;
                        //   Provider.of<DriverProfileUpdateViewModel>(context,
                        //       listen: false);
                        // }
                      }),
                  const SizedBox(height: 500),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return PageLayout_Curve(
    //   appHeading: "Update Information",
    //   child:
    // );
  }
}
