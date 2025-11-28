// To parse this JSON data, do
//
//     final upcomingPackagebookingModel = upcomingPackagebookingModelFromJson(jsonString);

import 'dart:convert';

UpcomingPackagebookingModel upcomingPackagebookingModelFromJson(String str) =>
    UpcomingPackagebookingModel.fromJson(json.decode(str));

String upcomingPackagebookingModelToJson(UpcomingPackagebookingModel data) =>
    json.encode(data.toJson());

class UpcomingPackagebookingModel {
  Status? status;
  List<Datum>? data;

  UpcomingPackagebookingModel({
    this.status,
    this.data,
  });

  factory UpcomingPackagebookingModel.fromJson(Map<String, dynamic> json) =>
      UpcomingPackagebookingModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? driverAssignedId;
  String? date;
  int? driverId;
  dynamic pickupLocation;
  Vehicle? vehicle;
  List<ActivityList>? activityList;
  bool? isCancelled;
  User? user;
  int? packageBookingId;
  String? dayStatus;
  dynamic startTimestamp;
  dynamic endTimestamp;
  String? pickupTime;
  String? mobile;
  String? countryCode;
  String? alternateMobile;
  String? alternateMobileCountryCode;
  int? vendorId;

  Datum({
    this.driverAssignedId,
    this.date,
    this.driverId,
    this.pickupLocation,
    this.vehicle,
    this.activityList,
    this.isCancelled,
    this.user,
    this.packageBookingId,
    this.dayStatus,
    this.startTimestamp,
    this.endTimestamp,
    this.pickupTime,
    this.mobile,
    this.countryCode,
    this.alternateMobile,
    this.alternateMobileCountryCode,
    this.vendorId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        driverAssignedId: json["driverAssignedId"],
        date: json["date"],
        driverId: json["driverId"],
        pickupLocation: json["pickupLocation"],
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        activityList: json["activityList"] == null
            ? []
            : List<ActivityList>.from(
                json["activityList"]!.map((x) => ActivityList.fromJson(x))),
        isCancelled: json["isCancelled"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        packageBookingId: json["packageBookingId"],
        dayStatus: json["dayStatus"],
        startTimestamp: json["startTimestamp"],
        endTimestamp: json["endTimestamp"],
        pickupTime: json["pickupTime"],
        mobile: json["mobile"],
        countryCode: json["countryCode"],
        alternateMobile: json["alternateMobile"],
        alternateMobileCountryCode: json["alternateMobileCountryCode"],
        vendorId: json["vendorId"],
      );

  Map<String, dynamic> toJson() => {
        "driverAssignedId": driverAssignedId,
        "date": date,
        "driverId": driverId,
        "pickupLocation": pickupLocation,
        "vehicle": vehicle?.toJson(),
        "activityList": activityList == null
            ? []
            : List<dynamic>.from(activityList!.map((x) => x.toJson())),
        "isCancelled": isCancelled,
        "user": user?.toJson(),
        "packageBookingId": packageBookingId,
        "dayStatus": dayStatus,
        "startTimestamp": startTimestamp,
        "endTimestamp": endTimestamp,
        "pickupTime": pickupTime,
        "mobile": mobile,
        "countryCode": countryCode,
        "alternateMobile": alternateMobile,
        "alternateMobileCountryCode": alternateMobileCountryCode,
        "vendorId": vendorId,
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
  List<String>? participantType;
  List<dynamic>? weeklyOff;
  List<String>? activityImageUrl;
  String? activityStatus;
  DateTime? createdDate;
  DateTime? modifiedDate;
  dynamic activityReligiousOffDates;
  AgeGroupDiscountPercent? ageGroupDiscountPercent;
  dynamic activityOfferMapping;
  String? activityCategory;

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
    this.participantType,
    this.weeklyOff,
    this.activityImageUrl,
    this.activityStatus,
    this.createdDate,
    this.modifiedDate,
    this.activityReligiousOffDates,
    this.ageGroupDiscountPercent,
    this.activityOfferMapping,
    this.activityCategory,
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
        participantType: json["participantType"] == null
            ? []
            : List<String>.from(json["participantType"]!.map((x) => x)),
        weeklyOff: json["weeklyOff"] == null
            ? []
            : List<dynamic>.from(json["weeklyOff"]!.map((x) => x)),
        activityImageUrl: json["activityImageUrl"] == null
            ? []
            : List<String>.from(json["activityImageUrl"]!.map((x) => x)),
        activityStatus: json["activityStatus"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.parse(json["modifiedDate"]),
        activityReligiousOffDates: json["activityReligiousOffDates"],
        ageGroupDiscountPercent: json["ageGroupDiscountPercent"] == null
            ? null
            : AgeGroupDiscountPercent.fromJson(json["ageGroupDiscountPercent"]),
        activityOfferMapping: json["activityOfferMapping"],
        activityCategory: json["activityCategory"],
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
        "participantType": participantType == null
            ? []
            : List<dynamic>.from(participantType!.map((x) => x)),
        "weeklyOff": weeklyOff == null
            ? []
            : List<dynamic>.from(weeklyOff!.map((x) => x)),
        "activityImageUrl": activityImageUrl == null
            ? []
            : List<dynamic>.from(activityImageUrl!.map((x) => x)),
        "activityStatus": activityStatus,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "activityReligiousOffDates": activityReligiousOffDates,
        "ageGroupDiscountPercent": ageGroupDiscountPercent?.toJson(),
        "activityOfferMapping": activityOfferMapping,
        "activityCategory": activityCategory,
      };
}

class AgeGroupDiscountPercent {
  double? child;
  double? infant;
  double? senior;

  AgeGroupDiscountPercent({
    this.child,
    this.infant,
    this.senior,
  });

  factory AgeGroupDiscountPercent.fromJson(Map<String, dynamic> json) =>
      AgeGroupDiscountPercent(
        child: json["CHILD"],
        infant: json["INFANT"],
        senior: json["SENIOR"],
      );

  Map<String, dynamic> toJson() => {
        "CHILD": child,
        "INFANT": infant,
        "SENIOR": senior,
      };
}

class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? address;
  String? email;
  String? gender;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? status;
  dynamic otp;
  dynamic isOtpVerified;
  String? userType;
  String? profileImageUrl;
  String? countryCode;
  dynamic notificationToken;
  String? lastLogin;
  String? country;
  String? state;
  bool? accountVerified;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.mobile,
    this.address,
    this.email,
    this.gender,
    this.createdDate,
    this.modifiedDate,
    this.status,
    this.otp,
    this.isOtpVerified,
    this.userType,
    this.profileImageUrl,
    this.countryCode,
    this.notificationToken,
    this.lastLogin,
    this.country,
    this.state,
    this.accountVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        address: json["address"],
        email: json["email"],
        gender: json["gender"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.parse(json["modifiedDate"]),
        status: json["status"],
        otp: json["otp"],
        isOtpVerified: json["isOtpVerified"],
        userType: json["userType"],
        profileImageUrl: json["profileImageUrl"],
        countryCode: json["countryCode"],
        notificationToken: json["notificationToken"],
        lastLogin: json["lastLogin"],
        country: json["country"],
        state: json["state"],
        accountVerified: json["accountVerified"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "address": address,
        "email": email,
        "gender": gender,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "status": status,
        "otp": otp,
        "isOtpVerified": isOtpVerified,
        "userType": userType,
        "profileImageUrl": profileImageUrl,
        "countryCode": countryCode,
        "notificationToken": notificationToken,
        "lastLogin": lastLogin,
        "country": country,
        "state": state,
        "accountVerified": accountVerified,
      };
}

class Vehicle {
  int? vehicleId;
  String? carName;
  int? year;
  String? carType;
  String? brandName;
  String? fuelType;
  int? seats;
  String? color;
  String? vehicleNumber;
  String? modelNo;
  DateTime? createdDate;
  DateTime? modifiedDate;
  List<String>? images;
  String? vehicleStatus;
  String? vehicleDocUrl;

  Vehicle({
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
    this.vehicleDocUrl,
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
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.parse(json["modifiedDate"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
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
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "vehicleStatus": vehicleStatus,
        "vehicleDocUrl": vehicleDocUrl,
      };
}

class Status {
  String? httpCode;
  bool? success;
  String? message;

  Status({
    this.httpCode,
    this.success,
    this.message,
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
