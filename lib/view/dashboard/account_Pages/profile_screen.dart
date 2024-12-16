import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/login/login_customTextFeild.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/view/dashboard/account_Pages/change_password_screen.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String dataUser = '';
  File? _image;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataUser = widget.user;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DriverProfileViewModel>(context, listen: false)
          .fetchDriverDetailViewModelApi(
              context, {"driverId": widget.user}, widget.user);
    });
  }

// Method to pick image from camera or gallery
  Future<void> _showImageSourceSelection() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Step 1: Pick an image from the selected source
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100, // Max quality
      );

      if (pickedFile != null) {
        // Step 2: Crop the image
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          cropStyle: CropStyle.rectangle,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1), // Square crop
          compressQuality: 100, // Max quality during cropping
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: btnColor,
              toolbarWidgetColor: Colors.white,
              hideBottomControls: true,
              lockAspectRatio: true,
            ),
            IOSUiSettings(title: 'Crop Image'),
          ],
        );

        if (croppedFile != null) {
          // Step 3: Compress the image
          var compressedFile = await _compressImage(File(croppedFile.path));

          setState(() {
            _image = compressedFile;
          });

          // Step 4: Upload the image
          await _uploadImage(_image!);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<File> _compressImage(File file) async {
    final dir = await Directory.systemTemp.createTemp();
    final targetPath = '${dir.path}/temp.jpg';
    final result1 = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 85, // Adjust quality as needed
      format: CompressFormat.jpeg,
    );
    final File result = File(result1?.path ?? '');

    return result; // Return the File
  }

  Future<void> _uploadImage(File file) async {
    var profilePic =
        await MultipartFile.fromFile(file.path, filename: "profile.jpg");
    Map<String, dynamic> body = {"driverId": widget.user, "image": profilePic};
    try {
      Provider.of<UploadProfilePicViewModel>(context, listen: false)
          .uploadProfilePic(context: context, body: body)
          .then((onValue) {
        Provider.of<DriverProfileViewModel>(context, listen: false)
            .fetchDriverDetailViewModelApi(
                context, {"driverId": userId}, userId);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  var userId;
  // var userName, userLastName, userMobile, userAdd, userEmail, userGender,userImg,userId;
  DriverProfileData? driverProfileData;
  @override
  Widget build(BuildContext context) {
    debugPrint(dataUser);

    driverProfileData =
        context.watch<DriverProfileViewModel>().DataList.data?.data;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomPagelayout(
        appBarTitle: 'Profile',
        actionIcon: InkWell(
          onTap: () {
            context.push("/profilePage/editProfilePage", extra: {
              'uId': dataUser,
              'phoneNo': driverProfileData?.mobile,
            });
            // .then((value) {
            //   Provider.of<DriverProfileViewModel>(context, listen: false)
            //       .fetchDriverDetailViewModelApi(
            //           context, {"driverId": userId}, userId);
            // });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Image.asset(
              edit,
              width: 26,
              height: 30,
              color: background,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(_image!),
                          radius: 60,
                        )
                      : (driverProfileData?.profileImageUrl ?? '').isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: Image.network(
                                      driverProfileData?.profileImageUrl ?? '')
                                  .image,
                              radius: 60,
                            )
                          : const CircleAvatar(
                              radius: 60,
                              child: Icon(Icons.person, size: 60),
                            ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: _showImageSourceSelection,
                      child: const Card(
                        elevation: 0,
                        shape: CircleBorder(),
                        color: btnColor,
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: background,
                            )),
                      ),
                    ),
                  )
                ],
              ),

              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _showImageSourceSelection,
              //   child: const Text("Select Profile Picture"),
              // ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Driver Id",
                headingReq: true,
                controller: TextEditingController(text: dataUser),
                prefixIcon: true,
                readOnly: true,
                img: idCard,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Full Name",
                headingReq: true,
                controller: TextEditingController(
                    text:
                        "${driverProfileData?.firstName ?? ''} ${driverProfileData?.lastName ?? ''}"),
                prefixIcon: true,
                readOnly: true,
                img: profile,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Email",
                headingReq: true,
                controller:
                    TextEditingController(text: driverProfileData?.email),
                prefixIcon: true,
                readOnly: true,
                img: email,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Gender",
                headingReq: true,
                prefixIcon: true,
                controller:
                    TextEditingController(text: driverProfileData?.gender),
                readOnly: true,
                img: gender,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Country",
                headingReq: true,
                prefixIcon: true,
                controller: TextEditingController(
                    text: driverProfileData?.country ?? ''),
                readOnly: true,
                img: address,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "State",
                headingReq: true,
                prefixIcon: true,
                controller:
                    TextEditingController(text: driverProfileData?.state ?? ''),
                readOnly: true,
                img: address,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Location",
                headingReq: true,
                prefixIcon: true,
                controller: TextEditingController(
                    text: driverProfileData?.driverAddress),
                readOnly: true,
                img: address,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Contact No",
                headingReq: true,
                prefixIcon: true,
                controller: TextEditingController(
                    text:
                        "+${driverProfileData?.countryCode ?? '971'} ${driverProfileData?.mobile ?? ''}"),
                readOnly: true,
                img: phone,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Emirates Id",
                headingReq: true,
                prefixIcon: true,
                controller:
                    TextEditingController(text: driverProfileData?.emiratesId),
                readOnly: true,
                img: emiID,
              ),
              const SizedBox(height: 10),
              CommonTextFeild(
                heading: "Licence Number",
                headingReq: true,
                prefixIcon: true,
                controller: TextEditingController(
                    text: driverProfileData?.licenceNumber),
                readOnly: true,
                img: drivingLic,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButtonSmall(
                    height: 45,
                    width: double.infinity,
                    btnHeading: 'CHANGE PASSWORD',
                    onTap: () {
                      _showModalBottomSheet(
                          context, ChangePassword(driverId: widget.user));
                    }),
              ),
              const SizedBox(height: 10),

              // Custom_ListTile(
              //   headingTitleReq: true,
              //   headingTitle: "Password",
              //   onTap: () => context.push("/verifyPassword"),
              //   heading: "**********",
              //   img: pass,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showModalBottomSheet(BuildContext context, Widget child) {
    print('chxzbcbxnzc xzbnmxbmn nbmnc xkjchnxmc x');
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
}

class ProfileContainer extends StatelessWidget {
  final dynamic imgPath;
  final VoidCallback onTap;
  final String name;

  const ProfileContainer(
      {required this.onTap, required this.imgPath, this.name = "", super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppDimension.getWidth(context) * .3,
          height: AppDimension.getHeight(context) * .2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: curvePageColor,
          ),
          child: imgPath.runtimeType != String
              ? Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(imgPath), fit: BoxFit.cover)),
                )
              :
              // imgPath.toString() == ""
              //     ? Container(
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: curvePageColor.withOpacity(0.5)),
              //   alignment: Alignment.center,
              //   child: Text(
              //     getInitials(name),
              //     style: const TextStyle(
              //         fontSize: 18, fontWeight: FontWeight.w700),
              //   ),
              // )
              //     :
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              // AppUrl.userProfileUpdate +
                              imgPath),
                          // image: AssetImage(imgPath),
                          fit: BoxFit.cover))),
          // child: const CircleAvatar(
          //   backgroundColor: curvePageColor,
          //   child: Icon(Icons.person,color: background,size: 40,),
          // ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: const Card(
              elevation: 0,
              shape: CircleBorder(),
              color: lightBrownColor,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: background,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
