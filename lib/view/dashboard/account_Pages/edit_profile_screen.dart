import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_driver/data/models/driver_profile_model.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/widgets/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/widgets/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/widgets/custom_text_form_field.dart';
import 'package:flutter_driver/widgets/custom_dropdown_button.dart';
import 'package:flutter_driver/widgets/custom_search_location.dart';
import 'package:flutter_driver/widgets/login/login_customTextFeild.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/view_model/driver_profile_view_model.dart';
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
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    var vm = context.read<DriverProfileViewModel>();
    await vm.getDriverByIdApi();
    var data = vm.getDriverDetails.data?.data;
    firstNameController.text = data?.firstName ?? '';
    lastNameController.text = data?.lastName ?? '';
    genderController.text = data?.gender ?? '';
    locationController.text = data?.driverAddress ?? '';
    phoneNumberController.text = widget.mobileNumber;
    countryController.text = data?.country ?? 'United Arab Emirates';
    stateController.text = data?.state ?? '';
    profileImg = data?.profileImageUrl ?? '';
    getCountry();
    // });
  }

  Dio? dio;
  String accessToken = '';
  void getCountry() async {
    debugPrint(
        'cnmxncmnbx../././././././././.. cmnnb ${countryController.text}');
    try {
      Provider.of<GetCountryStateListViewModel>(context, listen: false)
          .getStateList(
              context: context,
              country: countryController.text.isEmpty
                  ? 'United Arab Emirates'
                  : countryController.text);
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

  @override
  Widget build(BuildContext context) {
    var status = context.watch<DriverProfileViewModel>().updateDriver.status;
    var state = context.watch<GetCountryStateListViewModel>().getStateListModel;

   

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
                      items:
                          state?.map((stateName) => stateName).toList() ?? [],
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
                      loading: status == Status.loading,
                      btnHeading: "UPDATE",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<DriverProfileViewModel>()
                              .updateProfileApi(
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
                      }),
                  const SizedBox(height: 500),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
