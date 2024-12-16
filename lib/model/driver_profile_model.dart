///Driver Profile Model
class DriverProfileModel {
  DriverProfileStatus status;
  DriverProfileData data;

  DriverProfileModel({
    required this.status,
    required this.data,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) =>
      DriverProfileModel(
        status: DriverProfileStatus.fromJson(json["status"]),
        data: DriverProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverProfileData {
  String driverId;
  String firstName;
  String lastName;
  String driverAddress;
  String emiratesId;
  String mobile;
  String countryCode;
  String email;
  String gender;
  String licenceNumber;
  String createdDate;
  String modifiedDate;
  String profileImageUrl;
  String userType;
  String vendorId;
  // List<UnavailableDate> unavailableDates;
  String driverStatus;
  String lastLogin;
  String country;
  String state;
  DriverProfileData({
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.driverAddress,
    required this.emiratesId,
    required this.mobile,
    required this.countryCode,
    required this.email,
    required this.gender,
    required this.licenceNumber,
    required this.createdDate,
    required this.modifiedDate,
    required this.profileImageUrl,
    required this.userType,
    required this.vendorId,
    // required this.unavailableDates,
    required this.driverStatus,
    required this.lastLogin,
    required this.country,
    required this.state,
  });

  factory DriverProfileData.fromJson(Map<String, dynamic> json) =>
      DriverProfileData(
        driverId: json["driverId"].toString(),
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        driverAddress: json["driverAddress"] ?? '',
        emiratesId: json["emiratesId"] ?? '',
        mobile: json["mobile"] ?? '',
        countryCode: json["countryCode"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        licenceNumber: json["licenceNumber"] ?? '',
        createdDate: json["createdDate"].toString(),
        modifiedDate: json["modifiedDate"].toString(),
        profileImageUrl: json["profileImageUrl"] ?? '',
        userType: json["userType"] ?? '',
        vendorId: json["vendorId"].toString(),
        // unavailableDates: List<UnavailableDate>.from(json["unavailableDates"].map((x) => UnavailableDate.fromJson(x))),
        driverStatus: json["driverStatus"] ?? '',
        lastLogin: json['lastLogin']?.toString() ?? '',
        country: json["country"]?.toString() ?? '',
        state: json["state"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "firstName": firstName,
        "lastName": lastName,
        "driverAddress": driverAddress,
        "emiratesId": emiratesId,
        "mobile": mobile,
        "countryCode": countryCode,
        "email": email,
        "gender": gender,
        "licenceNumber": licenceNumber,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "profileImageUrl": profileImageUrl,
        "userType": userType,
        "vendorId": vendorId,
        // "unavailableDates": List<dynamic>.from(unavailableDates.map((x) => x.toJson())),
        "driverStatus": driverStatus,
        "lastLogin": lastLogin,
        "country": country,
        "state": state
      };
}



class DriverProfileStatus {
  String httpCode;
  String success;
  String message;

  DriverProfileStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverProfileStatus.fromJson(Map<String, dynamic> json) =>
      DriverProfileStatus(
        httpCode: json["httpCode"] ?? '',
        success: json["success"].toString(),
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}

///Driver Profile Update Model
class DriverProfileUpdateModel {
  DriverProfileUpdateStatus status;
  DriverProfileUpdateData data;

  DriverProfileUpdateModel({
    required this.status,
    required this.data,
  });

  factory DriverProfileUpdateModel.fromJson(Map<String, dynamic> json) =>
      DriverProfileUpdateModel(
        status: DriverProfileUpdateStatus.fromJson(json["status"]),
        data: DriverProfileUpdateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverProfileUpdateData {
  String driverId;
  String firstName;
  String lastName;
  String driverAddress;
  String emiratesId;
  String mobile;
  String countryCode;
  String email;
  String gender;
  String licenceNumber;
  String createdDate;
  String modifiedDate;
  String profileImageUrl;
  String userType;
  String vendorId;
  // List<UnavailableDate> unavailableDates;
  String driverStatus;

  DriverProfileUpdateData({
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.driverAddress,
    required this.emiratesId,
    required this.mobile,
    required this.countryCode,
    required this.email,
    required this.gender,
    required this.licenceNumber,
    required this.createdDate,
    required this.modifiedDate,
    required this.profileImageUrl,
    required this.userType,
    required this.vendorId,
    // required this.unavailableDates,
    required this.driverStatus,
  });

  factory DriverProfileUpdateData.fromJson(Map<String, dynamic> json) =>
      DriverProfileUpdateData(
        driverId: json["driverId"].toString(),
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        driverAddress: json["driverAddress"] ?? '',
        emiratesId: json["emiratesId"] ?? '',
        mobile: json["mobile"] ?? '',
        countryCode: json["countryCode"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        licenceNumber: json["licenceNumber"] ?? '',
        createdDate: json["createdDate"].toString(),
        modifiedDate: json["modifiedDate"].toString(),
        profileImageUrl: json["profileImageUrl"] ?? '',
        userType: json["userType"] ?? '',
        vendorId: json["vendorId"].toString(),
        // unavailableDates: List<UnavailableDate>.from(
        //     json["unavailableDates"].map((x) => UnavailableDate.fromJson(x))),
        driverStatus: json["driverStatus"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "firstName": firstName,
        "lastName": lastName,
        "driverAddress": driverAddress,
        "emiratesId": emiratesId,
        "mobile": mobile,
        "countryCode": countryCode,
        "email": email,
        "gender": gender,
        "licenceNumber": licenceNumber,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "profileImageUrl": profileImageUrl,
        "userType": userType,
        "vendorId": vendorId,
        // "unavailableDates":
        //     List<dynamic>.from(unavailableDates.map((x) => x.toJson())),
        "driverStatus": driverStatus,
      };
}

class UnavailableDate {
  String driverUnavailableId;
  String date;
  String driverUnavailableReason;
  String createdDate;
  String modifiedDate;
  String isCancelled;

  UnavailableDate({
    required this.driverUnavailableId,
    required this.date,
    required this.driverUnavailableReason,
    required this.createdDate,
    required this.modifiedDate,
    required this.isCancelled,
  });

  factory UnavailableDate.fromJson(Map<String, dynamic> json) =>
      UnavailableDate(
        driverUnavailableId: json["driverUnavailableId"].toString(),
        date: json["date"] ?? '',
        driverUnavailableReason: json["driverUnavailableReason"] ?? '',
        createdDate: json["createdDate"] ?? '',
        modifiedDate: json["modifiedDate"] ?? '',
        isCancelled: json["isCancelled"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "driverUnavailableId": driverUnavailableId,
        "date": date,
        "driverUnavailableReason": driverUnavailableReason,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "isCancelled": isCancelled,
      };
}

class DriverProfileUpdateStatus {
  String httpCode;
  String success;
  String message;

  DriverProfileUpdateStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverProfileUpdateStatus.fromJson(Map<String, dynamic> json) =>
      DriverProfileUpdateStatus(
        httpCode: json["httpCode"] ?? '',
        success: json["success"].toString(),
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}
