// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/widgets/custom_dropdown_button.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:flutter_driver/widgets/custom_phonefield.dart';
import 'package:flutter_driver/widgets/custom_search_location.dart';
import 'package:flutter_driver/widgets/image_picker_widget.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/view/auth_screens/change_password_screen.dart';
import 'package:flutter_driver/view_model/driver_profile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String driverId = '';
  String _profileImg = '';
  String countryCode = '971';
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emiratesController = TextEditingController();
  final TextEditingController _licenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDriverDetails();
  }

  void getDriverDetails() async {
    var vm = context.read<DriverProfileViewModel>();
    await vm.getDriverByIdApi();
    var data = vm.getDriverDetails.data?.data;
    _firstNameController.text = data?.firstName ?? '';
    _lastNameController.text = data?.lastName ?? '';
    _genderController.text = data?.gender ?? '';
    _emailController.text = data?.email ?? '';
    _locationController.text = data?.driverAddress ?? '';
    _contactController.text = data?.mobile ?? '';
    _countryController.text = data?.country ?? 'United Arab Emirates';
    _stateController.text = data?.state ?? '';
    _profileImg = data?.profileImageUrl ?? '';
    _emiratesController.text = data?.emiratesId ?? '';
    _licenceController.text = data?.licenceNumber ?? '';
    driverId = data?.driverId.toString() ?? '';
    getStateList();
  }

  void getStateList() async {
    try {
      context
          .read<GetCountryStateListViewModel>()
          .getStateList(country: _countryController.text);
    } catch (e) {
      debugPrint('error $e');
    }
  }

  void _uploadImage(File file) {
    try {
      context
          .read<DriverProfileViewModel>()
          .uploadProfilePicApi(file: file.path);
    } catch (e) {
      debugPrint('error $e');
    }
  }

  void _logout() async {
    try {
      UserViewModel().remove();

      context.go('/login');
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var stateList =
        context.watch<GetCountryStateListViewModel>().stateList.data;
    var updateStatus =
        context.watch<DriverProfileViewModel>().updateDriver.status;
    var getStatus =
        context.watch<DriverProfileViewModel>().getDriverDetails.status;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomPageLayout(
        appBarTitle: isEditing ? 'Edit Profile Screen' : 'Profile Screen',
        onTap: () {
          context.go('/'); // ALWAYS go to dashboard
        },
        actionIcon: IconButton(
            onPressed: () {
              _showLogoutConfirmation();
            },
            icon: Icon(
              Icons.logout,
              color: background,
            )),
        child: getStatus == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Center(
                            child: Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: btnColor)),
                          child: ImagePickerWidget(
                            initialImageUrl: _profileImg,
                            isEditable: true,
                            onImageSelected: _uploadImage,
                          ),
                        )),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _iconButton(
                              Icons.lock_outline,
                              'Change Password',
                              () {
                                _showModalBottomSheet(context,
                                    ChangePassword(driverId: driverId));
                              },
                            ),
                            _iconButton(
                              Icons.edit,
                              'Edit Profile',
                              () {
                                setState(() {
                                  isEditing = !isEditing;
                                });
                              },
                            )
                          ],
                        ),
                        const Divider(
                          height: 20,
                        ),
                        DetailItem(
                            icon: Icons.account_balance,
                            title: 'Driver Id',
                            readOnly: true,
                            controller: TextEditingController(text: driverId)),
                        DetailItem(
                          icon: Icons.person,
                          title: 'First Name',
                          readOnly: !isEditing,
                          controller: _firstNameController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                        DetailItem(
                          icon: Icons.person,
                          title: 'Last Name',
                          readOnly: !isEditing,
                          controller: _lastNameController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                        DetailItem(
                          icon: Icons.email,
                          title: 'Email',
                          readOnly: true,
                          controller: _emailController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter email address';
                            }
                            return null;
                          },
                        ),
                        DetailItem(
                          icon: Icons.male,
                          title: 'Gender',
                          readOnly: !isEditing,
                          child: CustomDropdownButton(
                            isEditable: isEditing,
                            withoutBorder: true,
                            itemsList: ['Male', 'Female'],
                            hintText: 'Select Gender',
                            controller: _genderController,
                            onChanged: (value) {
                              setState(() {
                                _genderController.text = value ?? '';
                              });
                            },
                          ),
                        ),
                        DetailItem(
                          readOnly: !isEditing,
                          icon: Icons.phone,
                          title: 'Contact No',
                          controller: _contactController,
                          child: Customphonefield(
                              readOnly: !isEditing,
                              withoutBorder: true,
                              hintText: 'Enter phone number',
                              fillColor: background,
                              initalCountryCode: countryCode,
                              controller: _contactController),
                        ),
                        DetailItem(
                          icon: Icons.public,
                          title: 'Country',
                          readOnly: !isEditing,
                          child: CustomDropdownButton(
                            isEditable: isEditing,
                            withoutBorder: true,
                            itemsList: [],
                            hintText: 'Select Country',
                            controller: _countryController,
                            onChanged: (value) {
                              setState(() {
                                _countryController.text = value ?? '';
                              });
                            },
                          ),
                        ),
                        DetailItem(
                          icon: Icons.location_city,
                          title: 'State',
                          readOnly: !isEditing,
                          child: CustomDropdownButton(
                            isEditable: isEditing,
                            withoutBorder: true,
                            itemsList: stateList ?? [],
                            hintText: 'Select State',
                            controller: _stateController,
                            onChanged: (value) {
                              setState(() {
                                _stateController.text = value ?? '';
                              });
                            },
                          ),
                        ),
                        DetailItem(
                          readOnly: !isEditing,
                          icon: Icons.location_on,
                          title: 'Location',
                          child: CustomSearchLocation(
                            isEditable: isEditing,
                            withoutBorder: true,
                            fillColor: background,
                            controller: _locationController,
                            state: _stateController.text,
                            hintText: 'Search location',
                          ),
                        ),
                        DetailItem(
                          icon: Icons.account_balance,
                          title: 'Emirates Id',
                          readOnly: true,
                          controller: _emiratesController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter emirates id';
                            }
                            return null;
                          },
                        ),
                        DetailItem(
                          icon: Icons.card_membership,
                          title: 'Licence Number',
                          readOnly: true,
                          controller: _licenceController,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter licence number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        if (isEditing)
                          CustomButtonSmall(
                            height: 45,
                            loading: updateStatus == Status.loading,
                            width: double.infinity,
                            btnHeading: 'Update',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<DriverProfileViewModel>()
                                    .updateProfileApi(
                                      context: context,
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      gender: _genderController.text,
                                      country: _countryController.text.isEmpty
                                          ? 'United Arab Emirates'
                                          : _countryController.text,
                                      state: _stateController.text,
                                      location: _locationController.text,
                                    );
                              }
                            },
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _showModalBottomSheet(BuildContext context, Widget child) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: background,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setstate) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: child,
              ),
            );
          });
        });
  }

  Widget _iconButton(IconData? icon, String lable, VoidCallback onTap) {
    return TextButton.icon(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(
            color: btnColor, // Border color
            width: 1.5, // Border width
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
          ),
        ),
      ),
      onPressed: onTap,
      label: Text(
        lable,
        style: TextStyle(color: btnColor, fontWeight: FontWeight.w600),
      ),
      icon: Icon(
        icon,
        color: btnColor,
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _logout();
              },
              child: Text(
                "Logout",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, color: btnColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? child;
  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const DetailItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.readOnly,
      this.controller,
      this.child,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: btnColor),
              const SizedBox(width: 10),
              Text(title, style: titleTextStyle),
            ],
          ),
          // const SizedBox(height: 4),
          child ??
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: readOnly,
                controller: controller,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54))),
                validator: validator,
              ),
        ],
      ),
    );
  }
}
