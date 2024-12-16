// To parse this JSON data, do
//
//     final driverPackageBookingHistoryListModel = driverPackageBookingHistoryListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DriverPackageBookingHistoryListModel
    driverPackageBookingHistoryListModelFromJson(String str) =>
        DriverPackageBookingHistoryListModel.fromJson(json.decode(str));

String driverPackageBookingHistoryListModelToJson(
        DriverPackageBookingHistoryListModel data) =>
    json.encode(data.toJson());

class DriverPackageBookingHistoryListModel {
  Status status;
  List<PackageHistoryData> data;

  DriverPackageBookingHistoryListModel({
    required this.status,
    required this.data,
  });

  factory DriverPackageBookingHistoryListModel.fromJson(
          Map<String, dynamic> json) =>
      DriverPackageBookingHistoryListModel(
        status: Status.fromJson(json["status"]),
        data: List<PackageHistoryData>.from(
            json["data"].map((x) => PackageHistoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PackageHistoryData {
  int? driverAssignedId;
  String? date;
  int? driverId;
  String? pickupLocation;
  Vehicle? vehicle;
  List<ActivityList> activityList;
  bool? isCancelled;
  User? user;
  int? packageBookingId;
  String? dayStatus;
  String? startTimestamp;
  String? endTimestamp;

  PackageHistoryData({
    required this.driverAssignedId,
    required this.date,
    required this.driverId,
    required this.pickupLocation,
    required this.vehicle,
    required this.activityList,
    required this.isCancelled,
    required this.user,
    required this.packageBookingId,
    required this.dayStatus,
    required this.startTimestamp,
    required this.endTimestamp,
  });

  factory PackageHistoryData.fromJson(Map<String, dynamic> json) =>
      PackageHistoryData(
        driverAssignedId: json["driverAssignedId"],
        date: json["date"],
        driverId: json["driverId"],
        pickupLocation: json["pickupLocation"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
        activityList: List<ActivityList>.from(
            json["activityList"].map((x) => ActivityList.fromJson(x))),
        isCancelled: json["isCancelled"],
        user: User.fromJson(json["user"]),
        packageBookingId: json["packageBookingId"],
        dayStatus: json["dayStatus"],
        startTimestamp: json["startTimestamp"],
        endTimestamp: json["endTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "driverAssignedId": driverAssignedId,
        "date": date,
        "driverId": driverId,
        "pickupLocation": pickupLocation,
        "vehicle": vehicle?.toJson(),
        "activityList": List<dynamic>.from(activityList.map((x) => x.toJson())),
        "isCancelled": isCancelled,
        "user": user?.toJson(),
        "packageBookingId": packageBookingId,
        "dayStatus": dayStatus,
        "startTimestamp": startTimestamp,
        "endTimestamp": endTimestamp,
      };
}

class ActivityList {
  int? activityId;
  String? country;
  String? state;
  String? city;
  String? address;
  String? activityName;
  String? bestTimeToVisit;
  double? activityHours;
  double? activityPrice;
  String? startTime;
  String? endTime;
  String? description;
  List<ParticipantType> participantType;
  List<WeeklyOff> weeklyOff;
  List<String> activityImageUrl;
  String? activityStatus;
  DateTime? createdDate;
  DateTime? modifiedDate;
  dynamic activityReligiousOffDates;

  ActivityList({
    required this.activityId,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.activityName,
    required this.bestTimeToVisit,
    required this.activityHours,
    required this.activityPrice,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.participantType,
    required this.weeklyOff,
    required this.activityImageUrl,
    required this.activityStatus,
    required this.createdDate,
    required this.modifiedDate,
    required this.activityReligiousOffDates,
  });

  factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
        activityId: json["activityId"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        activityName: json["activityName"],
        bestTimeToVisit: json["bestTimeToVisit"],
        activityHours: json["activityHours"],
        activityPrice: json["activityPrice"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        description: json["description"],
        participantType: List<ParticipantType>.from(
            json["participantType"].map((x) => participantTypeValues.map[x])),
        weeklyOff: List<WeeklyOff>.from(
            json["weeklyOff"].map((x) => weeklyOffValues.map[x])),
        activityImageUrl:
            List<String>.from(json["activityImageUrl"].map((x) => x)),
        activityStatus: json["activityStatus"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        activityReligiousOffDates: json["activityReligiousOffDates"],
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
        "participantType": List<dynamic>.from(
            participantType.map((x) => participantTypeValues.reverse[x])),
        "weeklyOff": List<dynamic>.from(
            weeklyOff.map((x) => weeklyOffValues.reverse[x])),
        "activityImageUrl": List<dynamic>.from(activityImageUrl.map((x) => x)),
        "activityStatus": activityStatus,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "activityReligiousOffDates": activityReligiousOffDates,
      };
}

enum ParticipantType { ADULT, SENIOR, TEEN }

final participantTypeValues = EnumValues({
  "ADULT": ParticipantType.ADULT,
  "SENIOR": ParticipantType.SENIOR,
  "TEEN": ParticipantType.TEEN
});

enum WeeklyOff { MONDAY, SUNDAY, WEDNESDAY }

final weeklyOffValues = EnumValues({
  "Monday": WeeklyOff.MONDAY,
  "Sunday": WeeklyOff.SUNDAY,
  "Wednesday": WeeklyOff.WEDNESDAY
});

class User {
  int userId;
  String firstName;
  String lastName;
  String mobile;
  String address;
  String email;
  String gender;
  DateTime createdDate;
  DateTime modifiedDate;
  bool status;
  dynamic otp;
  dynamic isOtpVerified;
  String userType;
  String profileImageUrl;
  String countryCode;
  dynamic notificationToken;

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
    required this.notificationToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        address: json["address"],
        email: json["email"],
        gender: json["gender"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        status: json["status"],
        otp: json["otp"],
        isOtpVerified: json["isOtpVerified"],
        userType: json["userType"],
        profileImageUrl: json["profileImageUrl"],
        countryCode: json["countryCode"],
        notificationToken: json["notificationToken"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "address": address,
        "email": email,
        "gender": gender,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "status": status,
        "otp": otp,
        "isOtpVerified": isOtpVerified,
        "userType": userType,
        "profileImageUrl": profileImageUrl,
        "countryCode": countryCode,
        "notificationToken": notificationToken,
      };
}

class Vehicle {
  int vehicleId;
  String carName;
  int year;
  String carType;
  String brandName;
  String fuelType;
  int seats;
  String color;
  String vehicleNumber;
  String modelNo;
  DateTime createdDate;
  DateTime modifiedDate;
  List<String> images;
  String vehicleStatus;
  dynamic vehicleDocUrl;

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
    required this.vehicleDocUrl,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json["vehicleId"],
        carName: json["carName"],
        year: json["year"],
        carType: json["carType"],
        brandName: json["brandName"],
        fuelType: json["fuelType"],
        seats: json["seats"],
        color: json["color"],
        vehicleNumber: json["vehicleNumber"],
        modelNo: json["modelNo"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        images: List<String>.from(json["images"].map((x) => x)),
        vehicleStatus: json["vehicleStatus"],
        vehicleDocUrl: json["vehicleDocUrl"],
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
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "vehicleStatus": vehicleStatus,
        "vehicleDocUrl": vehicleDocUrl,
      };
}

class Status {
  String httpCode;
  bool success;
  String message;

  Status({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
