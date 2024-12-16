import 'dart:convert';

class DriverPackageBookingListModel {
  Status status;
  List<Datum> data;

  DriverPackageBookingListModel({
    required this.status,
    required this.data,
  });

  factory DriverPackageBookingListModel.fromJson(Map<String, dynamic> json) =>
      DriverPackageBookingListModel(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String? driverAssignedId;
  String? date;
  String? driverId;
  String? pickupLocation;
  Vehicle? vehicle;
  List<ActivityList> activityList;
  String? isCancelled;
  User? user;
  int? packageBookingId;
  String? dayStatus;
  String? pickupTime;
  String? startTimestamp;
  String? endTimestamp;

  Datum({
    this.driverAssignedId,
    this.date,
    this.driverId,
    this.pickupLocation,
    this.vehicle,
    required this.activityList,
    this.isCancelled,
    this.user,
    this.packageBookingId,
    this.dayStatus,
    this.pickupTime,
    this.startTimestamp,
    this.endTimestamp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        driverAssignedId: json["driverAssignedId"]?.toString() ?? "",
        date: json["date"]?.toString() ?? "",
        driverId: json["driverId"]?.toString() ?? "",
        pickupLocation: json["pickupLocation"],
        vehicle: Vehicle.fromJson(json["vehicle"] ?? {}),
        activityList: List<ActivityList>.from(
            json["activityList"].map((x) => ActivityList.fromJson(x))),
        isCancelled: json["isCancelled"]?.toString() ?? "",
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        packageBookingId: json["packageBookingId"],
        dayStatus: json["dayStatus"],
        pickupTime: json['pickupTime'],
        startTimestamp: json["startTimestamp"],
        endTimestamp: json["endTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "driverAssignedId": driverAssignedId,
        "date": date,
        "driverId": driverId,
        "pickupLocation": pickupLocation,
        "vehicle": vehicle,
        "activityList": List<dynamic>.from(activityList.map((x) => x.toJson())),
        "isCancelled": isCancelled,
        "user": user?.toJson(),
        "packageBookingId": packageBookingId,
        "dayStatus": dayStatus,
        "pickupTime": pickupTime,
        "startTimestamp": startTimestamp,
        "endTimestamp": endTimestamp,
      };
}

class Vehicle {
  String vehicleId;
  String carName;
  String year;
  String carType;
  String brandName;
  String fuelType;
  String seats;
  String color;
  String vehicleNumber;
  String modelNo;
  String createdDate;
  String modifiedDate;
  List<String> images;
  String vehicleStatus;
  String unavailableDates;

  Vehicle({
    required this.vehicleId,
    required this.carName,
    required this.year,
    required this.carType,
    required this.brandName,
    required this.fuelType,
    required this.seats,
    required this.color,
    required this.vehicleNumber,
    required this.modelNo,
    required this.createdDate,
    required this.modifiedDate,
    required this.images,
    required this.vehicleStatus,
    required this.unavailableDates,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json["vehicleId"]?.toString() ?? "",
        carName: json["carName"]?.toString() ?? "",
        year: json["year"]?.toString() ?? "",
        carType: json["carType"]?.toString() ?? "",
        brandName: json["brandName"]?.toString() ?? "",
        fuelType: json["fuelType"]?.toString() ?? "",
        seats: json["seats"]?.toString() ?? "",
        color: json["color"]?.toString() ?? "",
        vehicleNumber: json["vehicleNumber"]?.toString() ?? "",
        modelNo: json["modelNo"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
        images:
            List<String>.from(json["images"]?.map((x) => x.toString()) ?? []),
        vehicleStatus: json["vehicleStatus"]?.toString() ?? "",
        unavailableDates: json["unavailableDates"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "carName": carName,
        "year": year,
        "carType": carType,
        "brandName": brandName,
        "fuelType": fuelType,
        "seats": seats,
        "color": color,
        "vehicleNumber": vehicleNumber,
        "modelNo": modelNo,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "images": List<dynamic>.from(images.map((x) => x)),
        "vehicleStatus": vehicleStatus,
        "unavailableDates": unavailableDates,
      };
}

class ActivityList {
  String? activityId;
  String? country;
  String? state;
  String? city;
  String? address;
  String? activityName;
  String? bestTimeToVisit;
  String? activityHours;
  String? activityPrice;
  String? startTime;
  String? endTime;
  String? description;
  // List<String> weeklyOff;
  List<String> activityImageUrl;
  String? activityStatus;
  String? createdDate;
  String? modifiedDate;

  ActivityList({
    this.activityId,
    this.country,
    this.state,
    this.city,
    this.address,
    this.activityName,
    this.bestTimeToVisit,
    this.activityHours,
    this.activityPrice,
    this.startTime,
    this.endTime,
    this.description,
    // required this.weeklyOff,
    required this.activityImageUrl,
    this.activityStatus,
    this.createdDate,
    this.modifiedDate,
  });

  factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
        activityId: json["activityId"]?.toString() ?? "",
        country: json["country"]?.toString() ?? "",
        state: json["state"]?.toString() ?? "",
        city: json["city"]?.toString() ?? "",
        address: json["address"]?.toString() ?? "",
        activityName: json["activityName"]?.toString() ?? "",
        bestTimeToVisit: json["bestTimeToVisit"]?.toString() ?? "",
        activityHours: json["activityHours"]?.toString() ?? "",
        activityPrice: json["activityPrice"]?.toString() ?? "",
        startTime: json["startTime"]?.toString() ?? "",
        endTime: json["endTime"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        // weeklyOff: List<String>.from(json["weeklyOff"].map((x) => x)),
        activityImageUrl:
            List<String>.from(json["activityImageUrl"].map((x) => x)),
        activityStatus: json["activityStatus"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "activityName": activityName,
        "bestTimeToVisit": bestTimeToVisit,
        "activityHours": activityHours,
        "activityPrice": activityPrice,
        "startTime": startTime,
        "endTime": endTime,
        "description": description,
        // "weeklyOff": List<dynamic>.from(weeklyOff.map((x) => x)),
        "activityImageUrl": List<dynamic>.from(activityImageUrl.map((x) => x)),
        "activityStatus": activityStatus,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
      };
}

class Status {
  String httpCode;
  String success;
  String message;

  Status({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        httpCode: json["httpCode"] ?? "",
        success: json["success"].toString(),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}

///Package Details Model
class DriverPackageDetailModel {
  PackageDetailStatus status;
  Data data;

  DriverPackageDetailModel({
    required this.status,
    required this.data,
  });

  factory DriverPackageDetailModel.fromJson(Map<String, dynamic> json) =>
      DriverPackageDetailModel(
        status: PackageDetailStatus.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  String? driverAssignedId;
  String? date;
  String? driverId;
  String? pickupLocation;
  PackageDetailVehicle? vehicle;
  List<PackageDetailActivityList>? activityList;
  String? isCancelled;
  User? user;
  String? packageBookingId;
  String? dayStatus;
  String? countryCode;
  String? mobile;
  String? alternateMobileCountryCode;
  String? alternateMobile;
  String? pickupTime;
  String? startTimestamp;
  String? endTimestamp;

  Data(
      {this.driverAssignedId,
      this.date,
      this.driverId,
      this.pickupLocation,
      this.vehicle,
      this.activityList,
      this.isCancelled,
      this.user,
      this.packageBookingId,
      this.dayStatus,
      this.countryCode,
      this.mobile,
      this.alternateMobileCountryCode,
      this.alternateMobile,
      this.pickupTime,
      this.startTimestamp,
      this.endTimestamp});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        driverAssignedId: json["driverAssignedId"]?.toString() ?? "",
        date: json["date"],
        driverId: json["driverId"]?.toString() ?? "",
        pickupLocation: json["pickupLocation"],
        vehicle: PackageDetailVehicle.fromJson(json["vehicle"] ?? {}),
        activityList: List<PackageDetailActivityList>.from(json["activityList"]
            .map((x) => PackageDetailActivityList.fromJson(x))),
        isCancelled: json["isCancelled"]?.toString() ?? "",
        user: User.fromJson(json['user']),
        packageBookingId: json['packageBookingId']?.toString() ?? "",
        dayStatus: json['dayStatus']?.toString() ?? "",
        countryCode: json["countryCode"] ?? '',
        mobile: json["mobile"] ?? '',
        alternateMobileCountryCode: json["alternateMobileCountryCode"] ?? '',
        alternateMobile: json["alternateMobile"] ?? '',
        pickupTime: json['pickupTime'],
        startTimestamp: json['startTimestamp']?.toString() ?? "",
        endTimestamp: json['endTimestamp']?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "driverAssignedId": driverAssignedId,
        "date": date,
        "driverId": driverId,
        "pickupLocation": pickupLocation,
        "vehicle": vehicle,
        "activityList":
            List<dynamic>.from(activityList!.map((x) => x.toJson())),
        "isCancelled": isCancelled,
        "user": user,
        "packageBookingId": packageBookingId,
        "dayStatus": dayStatus,
        "countryCode": countryCode,
        "mobile": mobile,
        "alternateMobile": alternateMobile,
        "alternateMobileCountryCode": alternateMobileCountryCode,
        "pickupTime": pickupTime,
        "startTimestamp": startTimestamp,
        "endTimestamp": endTimestamp,
      };
}

class PackageDetailActivityList {
  String? activityId;
  String? country;
  String? state;
  String? city;
  String? address;
  String? activityName;
  String? bestTimeToVisit;
  String? activityHours;
  String? activityPrice;
  String? startTime;
  String? endTime;
  String? description;
  // List<String>? participantType;
  // List<String>? weeklyOff;
  List<String>? activityImageUrl;
  String? activityStatus;
  String? createdDate;
  String? modifiedDate;
  // List<ActivityReligiousOffDate> activityReligiousOffDates;

  PackageDetailActivityList({
    this.activityId,
    this.country,
    this.state,
    this.city,
    this.address,
    this.activityName,
    this.bestTimeToVisit,
    this.activityHours,
    this.activityPrice,
    this.startTime,
    this.endTime,
    this.description,
    // required this.participantType,
    // required this.weeklyOff,
    this.activityImageUrl,
    this.activityStatus,
    this.createdDate,
    this.modifiedDate,
    // required this.activityReligiousOffDates,
  });

  factory PackageDetailActivityList.fromJson(Map<String, dynamic> json) =>
      PackageDetailActivityList(
        activityId: json["activityId"]?.toString() ?? "",
        country: json["country"]?.toString() ?? "",
        state: json["state"]?.toString() ?? "",
        city: json["city"]?.toString() ?? "",
        address: json["address"]?.toString() ?? "",
        activityName: json["activityName"]?.toString() ?? "",
        bestTimeToVisit: json["bestTimeToVisit"]?.toString() ?? "",
        activityHours: json["activityHours"]?.toString() ?? "",
        activityPrice: json["activityPrice"]?.toString() ?? "",
        startTime: json["startTime"]?.toString() ?? "",
        endTime: json["endTime"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        // participantType: List<String>.from(json["participantType"].map((x) => x)),
        // weeklyOff: List<String>.from(json["weeklyOff"].map((x) => x)),
        activityImageUrl:
            List<String>.from(json["activityImageUrl"].map((x) => x)),
        activityStatus: json["activityStatus"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
        // activityReligiousOffDates: List<ActivityReligiousOffDate>.from(json["activityReligiousOffDates"].map((x) => ActivityReligiousOffDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "activityName": activityName,
        "bestTimeToVisit": bestTimeToVisit,
        "activityHours": activityHours,
        "activityPrice": activityPrice,
        "startTime": startTime,
        "endTime": endTime,
        "description": description,
        // "participantType": List<dynamic>.from(participantType.map((x) => x)),
        // "weeklyOff": List<dynamic>.from(weeklyOff.map((x) => x)),
        "activityImageUrl": List<dynamic>.from(activityImageUrl!.map((x) => x)),
        "activityStatus": activityStatus,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        // "activityReligiousOffDates": List<dynamic>.from(activityReligiousOffDates.map((x) => x.toJson())),
      };
}

class User {
  String userId;
  String firstName;
  String lastName;
  String mobile;
  String address;
  String email;
  String gender;
  String createdDate;
  String modifiedDate;
  bool status;
  String otp;
  String isOtpVerified;
  String userType;
  String profileImageUrl;
  String countryCode;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.address,
    required this.email,
    required this.gender,
    required this.createdDate,
    required this.modifiedDate,
    required this.status,
    required this.otp,
    required this.isOtpVerified,
    required this.userType,
    required this.profileImageUrl,
    required this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"].toString(),
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        mobile: json["mobile"] ?? "",
        address: json["address"] ?? "",
        email: json["email"] ?? "",
        gender: json["gender"] ?? "",
        createdDate: json["createdDate"] ?? "",
        modifiedDate: json["modifiedDate"] ?? "",
        status: json["status"] ?? false,
        otp: json["otp"].toString(),
        isOtpVerified: json["isOtpVerified"].toString(),
        userType: json["userType"] ?? "",
        profileImageUrl: json["profileImageUrl"] ?? "",
        countryCode: json["countryCode"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "address": address,
        "email": email,
        "gender": gender,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "status": status,
        "otp": otp,
        "isOtpVerified": isOtpVerified,
        "userType": userType,
        "profileImageUrl": profileImageUrl,
        "countryCode": countryCode,
      };
}

class PackageDetailVehicle {
  String? vehicleId;
  String? carName;
  String? year;
  String? carType;
  String? brandName;
  String? fuelType;
  String? seats;
  String? color;
  String? vehicleNumber;
  String? modelNo;
  String? createdDate;
  String? modifiedDate;
  List<String>? images;
  String? vehicleStatus;
  // String unavailableDates;

  PackageDetailVehicle({
    this.vehicleId,
    this.carName,
    this.year,
    this.carType,
    this.brandName,
    this.fuelType,
    this.seats,
    this.color,
    this.vehicleNumber,
    this.modelNo,
    this.createdDate,
    this.modifiedDate,
    this.images,
    this.vehicleStatus,
    // required this.unavailableDates,
  });

  factory PackageDetailVehicle.fromJson(Map<String, dynamic> json) =>
      PackageDetailVehicle(
        vehicleId: json["vehicleId"]?.toString() ?? "",
        carName: json["carName"]?.toString() ?? "",
        year: json["year"]?.toString() ?? "",
        carType: json["carType"]?.toString() ?? "",
        brandName: json["brandName"]?.toString() ?? "",
        fuelType: json["fuelType"]?.toString() ?? "",
        seats: json["seats"]?.toString() ?? "",
        color: json["color"]?.toString() ?? "",
        vehicleNumber: json["vehicleNumber"]?.toString() ?? "",
        modelNo: json["modelNo"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
        images: List<String>.from(json["images"].map((x) => x) ?? []),
        vehicleStatus: json["vehicleStatus"]?.toString() ?? "",
        // unavailableDates: json["unavailableDates"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "carName": carName,
        "year": year,
        "carType": carType,
        "brandName": brandName,
        "fuelType": fuelType,
        "seats": seats,
        "color": color,
        "vehicleNumber": vehicleNumber,
        "modelNo": modelNo,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "vehicleStatus": vehicleStatus,
        // "unavailableDates": unavailableDates,
      };
}

class PackageDetailStatus {
  String httpCode;
  bool success;
  String message;

  PackageDetailStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory PackageDetailStatus.fromJson(Map<String, dynamic> json) =>
      PackageDetailStatus(
        httpCode: json["httpCode"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}

class DriverActivityStartModel {
  DriverActivityStartStatus status;
  DriverActivityStart data;

  DriverActivityStartModel({
    required this.status,
    required this.data,
  });

  factory DriverActivityStartModel.fromJson(Map<String, dynamic> json) =>
      DriverActivityStartModel(
        status: DriverActivityStartStatus.fromJson(json["status"]),
        data: DriverActivityStart.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverActivityStart {
  Headers headers;
  String body;
  String statusCode;
  int statusCodeValue;

  DriverActivityStart({
    required this.headers,
    required this.body,
    required this.statusCode,
    required this.statusCodeValue,
  });

  factory DriverActivityStart.fromJson(Map<String, dynamic> json) =>
      DriverActivityStart(
        headers: Headers.fromJson(json["headers"]),
        body: json["body"],
        statusCode: json["statusCode"],
        statusCodeValue: json["statusCodeValue"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers.toJson(),
        "body": body,
        "statusCode": statusCode,
        "statusCodeValue": statusCodeValue,
      };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers();

  Map<String, dynamic> toJson() => {};
}

class DriverActivityStartStatus {
  String httpCode;
  bool success;
  String message;

  DriverActivityStartStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverActivityStartStatus.fromJson(Map<String, dynamic> json) =>
      DriverActivityStartStatus(
        httpCode: json["httpCode"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}

class DriverActivityCompleteModel {
  DriverActivityCompleteStatus status;
  DriverActivityCompleteData data;

  DriverActivityCompleteModel({
    required this.status,
    required this.data,
  });

  factory DriverActivityCompleteModel.fromJson(Map<String, dynamic> json) =>
      DriverActivityCompleteModel(
        status: DriverActivityCompleteStatus.fromJson(json["status"]),
        data: DriverActivityCompleteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverActivityCompleteData {
  Headers headers;
  String body;
  String statusCode;
  int statusCodeValue;

  DriverActivityCompleteData({
    required this.headers,
    required this.body,
    required this.statusCode,
    required this.statusCodeValue,
  });

  factory DriverActivityCompleteData.fromJson(Map<String, dynamic> json) =>
      DriverActivityCompleteData(
        headers: Headers.fromJson(json["headers"]),
        body: json["body"],
        statusCode: json["statusCode"],
        statusCodeValue: json["statusCodeValue"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers.toJson(),
        "body": body,
        "statusCode": statusCode,
        "statusCodeValue": statusCodeValue,
      };
}

class CompleteHeaders {
  CompleteHeaders();

  factory CompleteHeaders.fromJson(Map<String, dynamic> json) =>
      CompleteHeaders();

  Map<String, dynamic> toJson() => {};
}

class DriverActivityCompleteStatus {
  String httpCode;
  bool success;
  String message;

  DriverActivityCompleteStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverActivityCompleteStatus.fromJson(Map<String, dynamic> json) =>
      DriverActivityCompleteStatus(
        httpCode: json["httpCode"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "httpCode": httpCode,
        "success": success,
        "message": message,
      };
}
