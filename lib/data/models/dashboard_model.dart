// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_driver/data/models/rental_booking_model.dart';
import 'package:flutter_driver/data/models/upcoming_package_booking_model.dart';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  Status? status;
  DashboardData? data;

  DashboardModel({
    this.status,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data:
            json["data"] == null ? null : DashboardData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class DashboardData {
  int? todayRideCount;
  int? upcomingRideCount;
  List<BookingContent>? recentRentalRides;
  List<Datum>? recentPackageRides;

  DashboardData({
    this.todayRideCount,
    this.upcomingRideCount,
    this.recentRentalRides,
    this.recentPackageRides,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        todayRideCount: json["todayRideCount"],
        upcomingRideCount: json["upcomingRideCount"],
        recentRentalRides: json["recentRentalRides"] == null
            ? []
            : List<BookingContent>.from(json["recentRentalRides"]!
                .map((x) => BookingContent.fromJson(x))),
        recentPackageRides: json["recentPackageRides"] == null
            ? []
            : List<Datum>.from(
                json["recentPackageRides"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "todayRideCount": todayRideCount,
        "upcomingRideCount": upcomingRideCount,
        "recentRentalRides": recentRentalRides == null
            ? []
            : List<dynamic>.from(recentRentalRides!.map((x) => x.toJson())),
        "recentPackageRides": recentPackageRides == null
            ? []
            : List<dynamic>.from(recentPackageRides!.map((x) => x.toJson())),
      };
}

// class RecentRentalRide {
//   int? id;
//   String? rentalBookingId;
//   String? date;
//   String? pickupTime;
//   double? locationLongitude;
//   double? locationLatitude;
//   String? bookingStatus;
//   int? totalRentTime;
//   int? kilometers;
//   bool? paidStatus;
//   dynamic userId;
//   String? carType;
//   dynamic extraMinutes;
//   dynamic extraKilometers;
//   int? createdDate;
//   int? modifiedDate;
//   dynamic rentalManagement;
//   Vehicle? vehicle;
//   Driver? driver;
//   dynamic rideStartTime;
//   dynamic rideEndTime;
//   String? pickupLocation;
//   dynamic cancellationReason;
//   int? bookerId;
//   int? bookingForId;
//   User? user;
//   dynamic guest;
//   dynamic cancelledBy;
//   String? paymentId;
//   String? offerCode;
//   double? rentalCharge;
//   double? taxAmount;
//   double? taxPercentage;
//   double? discountAmount;
//   double? totalPayableAmount;
//   int? vendorId;

//   RecentRentalRide({
//     this.id,
//     this.rentalBookingId,
//     this.date,
//     this.pickupTime,
//     this.locationLongitude,
//     this.locationLatitude,
//     this.bookingStatus,
//     this.totalRentTime,
//     this.kilometers,
//     this.paidStatus,
//     this.userId,
//     this.carType,
//     this.extraMinutes,
//     this.extraKilometers,
//     this.createdDate,
//     this.modifiedDate,
//     this.rentalManagement,
//     this.vehicle,
//     this.driver,
//     this.rideStartTime,
//     this.rideEndTime,
//     this.pickupLocation,
//     this.cancellationReason,
//     this.bookerId,
//     this.bookingForId,
//     this.user,
//     this.guest,
//     this.cancelledBy,
//     this.paymentId,
//     this.offerCode,
//     this.rentalCharge,
//     this.taxAmount,
//     this.taxPercentage,
//     this.discountAmount,
//     this.totalPayableAmount,
//     this.vendorId,
//   });

//   factory RecentRentalRide.fromJson(Map<String, dynamic> json) =>
//       RecentRentalRide(
//         id: json["id"],
//         rentalBookingId: json["rentalBookingId"],
//         date: json["date"],
//         pickupTime: json["pickupTime"],
//         locationLongitude: json["locationLongitude"]?.toDouble(),
//         locationLatitude: json["locationLatitude"]?.toDouble(),
//         bookingStatus: json["bookingStatus"],
//         totalRentTime: json["totalRentTime"],
//         kilometers: json["kilometers"],
//         paidStatus: json["paidStatus"],
//         userId: json["userId"],
//         carType: json["carType"],
//         extraMinutes: json["extraMinutes"],
//         extraKilometers: json["extraKilometers"],
//         createdDate: json["createdDate"],
//         modifiedDate: json["modifiedDate"],
//         rentalManagement: json["rentalManagement"],
//         vehicle:
//             json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
//         driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
//         rideStartTime: json["rideStartTime"],
//         rideEndTime: json["rideEndTime"],
//         pickupLocation: json["pickupLocation"],
//         cancellationReason: json["cancellationReason"],
//         bookerId: json["bookerId"],
//         bookingForId: json["bookingForId"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         guest: json["guest"],
//         cancelledBy: json["cancelledBy"],
//         paymentId: json["paymentId"],
//         offerCode: json["offerCode"],
//         rentalCharge: json["rentalCharge"],
//         taxAmount: json["taxAmount"]?.toDouble(),
//         taxPercentage: json["taxPercentage"],
//         discountAmount: json["discountAmount"],
//         totalPayableAmount: json["totalPayableAmount"],
//         vendorId: json["vendorId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "rentalBookingId": rentalBookingId,
//         "date": date,
//         "pickupTime": pickupTime,
//         "locationLongitude": locationLongitude,
//         "locationLatitude": locationLatitude,
//         "bookingStatus": bookingStatus,
//         "totalRentTime": totalRentTime,
//         "kilometers": kilometers,
//         "paidStatus": paidStatus,
//         "userId": userId,
//         "carType": carType,
//         "extraMinutes": extraMinutes,
//         "extraKilometers": extraKilometers,
//         "createdDate": createdDate,
//         "modifiedDate": modifiedDate,
//         "rentalManagement": rentalManagement,
//         "vehicle": vehicle?.toJson(),
//         "driver": driver?.toJson(),
//         "rideStartTime": rideStartTime,
//         "rideEndTime": rideEndTime,
//         "pickupLocation": pickupLocation,
//         "cancellationReason": cancellationReason,
//         "bookerId": bookerId,
//         "bookingForId": bookingForId,
//         "user": user?.toJson(),
//         "guest": guest,
//         "cancelledBy": cancelledBy,
//         "paymentId": paymentId,
//         "offerCode": offerCode,
//         "rentalCharge": rentalCharge,
//         "taxAmount": taxAmount,
//         "taxPercentage": taxPercentage,
//         "discountAmount": discountAmount,
//         "totalPayableAmount": totalPayableAmount,
//         "vendorId": vendorId,
//       };
// }

// class RecentPackageRide {
//   int? driverAssignedId;
//   String? date;
//   int? driverId;
//   String? pickupLocation;
//   Vehicle? vehicle;
//   List<ActivityList>? activityList;
//   bool? isCancelled;
//   User? user;
//   int? packageBookingId;
//   String? dayStatus;
//   dynamic startTimestamp;
//   dynamic endTimestamp;
//   String? pickupTime;
//   String? mobile;
//   String? countryCode;
//   String? alternateMobile;
//   String? alternateMobileCountryCode;
//   int? vendorId;

//   RecentPackageRide({
//     this.driverAssignedId,
//     this.date,
//     this.driverId,
//     this.pickupLocation,
//     this.vehicle,
//     this.activityList,
//     this.isCancelled,
//     this.user,
//     this.packageBookingId,
//     this.dayStatus,
//     this.startTimestamp,
//     this.endTimestamp,
//     this.pickupTime,
//     this.mobile,
//     this.countryCode,
//     this.alternateMobile,
//     this.alternateMobileCountryCode,
//     this.vendorId,
//   });

//   factory RecentPackageRide.fromJson(Map<String, dynamic> json) =>
//       RecentPackageRide(
//         driverAssignedId: json["driverAssignedId"],
//         date: json["date"],
//         driverId: json["driverId"],
//         pickupLocation: json["pickupLocation"],
//         vehicle:
//             json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
//         activityList: json["activityList"] == null
//             ? []
//             : List<ActivityList>.from(
//                 json["activityList"]!.map((x) => ActivityList.fromJson(x))),
//         isCancelled: json["isCancelled"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         packageBookingId: json["packageBookingId"],
//         dayStatus: json["dayStatus"],
//         startTimestamp: json["startTimestamp"],
//         endTimestamp: json["endTimestamp"],
//         pickupTime: json["pickupTime"],
//         mobile: json["mobile"],
//         countryCode: json["countryCode"],
//         alternateMobile: json["alternateMobile"],
//         alternateMobileCountryCode: json["alternateMobileCountryCode"],
//         vendorId: json["vendorId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "driverAssignedId": driverAssignedId,
//         "date": date,
//         "driverId": driverId,
//         "pickupLocation": pickupLocation,
//         "vehicle": vehicle?.toJson(),
//         "activityList": activityList == null
//             ? []
//             : List<dynamic>.from(activityList!.map((x) => x.toJson())),
//         "isCancelled": isCancelled,
//         "user": user?.toJson(),
//         "packageBookingId": packageBookingId,
//         "dayStatus": dayStatus,
//         "startTimestamp": startTimestamp,
//         "endTimestamp": endTimestamp,
//         "pickupTime": pickupTime,
//         "mobile": mobile,
//         "countryCode": countryCode,
//         "alternateMobile": alternateMobile,
//         "alternateMobileCountryCode": alternateMobileCountryCode,
//         "vendorId": vendorId,
//       };
// }

// class ActivityList {
//   int? activityId;
//   String? country;
//   String? state;
//   String? city;
//   String? address;
//   String? activityName;
//   String? bestTimeToVisit;
//   double? activityHours;
//   double? activityPrice;
//   String? startTime;
//   String? endTime;
//   String? description;
//   List<String>? participantType;
//   List<dynamic>? weeklyOff;
//   List<String>? activityImageUrl;
//   String? activityStatus;
//   DateTime? createdDate;
//   DateTime? modifiedDate;
//   dynamic activityReligiousOffDates;
//   AgeGroupDiscountPercent? ageGroupDiscountPercent;
//   dynamic activityOfferMapping;
//   String? activityCategory;

//   ActivityList({
//     this.activityId,
//     this.country,
//     this.state,
//     this.city,
//     this.address,
//     this.activityName,
//     this.bestTimeToVisit,
//     this.activityHours,
//     this.activityPrice,
//     this.startTime,
//     this.endTime,
//     this.description,
//     this.participantType,
//     this.weeklyOff,
//     this.activityImageUrl,
//     this.activityStatus,
//     this.createdDate,
//     this.modifiedDate,
//     this.activityReligiousOffDates,
//     this.ageGroupDiscountPercent,
//     this.activityOfferMapping,
//     this.activityCategory,
//   });

//   factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
//         activityId: json["activityId"],
//         country: json["country"],
//         state: json["state"],
//         city: json["city"],
//         address: json["address"],
//         activityName: json["activityName"],
//         bestTimeToVisit: json["bestTimeToVisit"],
//         activityHours: json["activityHours"],
//         activityPrice: json["activityPrice"],
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         description: json["description"],
//         participantType: json["participantType"] == null
//             ? []
//             : List<String>.from(json["participantType"]!.map((x) => x)),
//         weeklyOff: json["weeklyOff"] == null
//             ? []
//             : List<dynamic>.from(json["weeklyOff"]!.map((x) => x)),
//         activityImageUrl: json["activityImageUrl"] == null
//             ? []
//             : List<String>.from(json["activityImageUrl"]!.map((x) => x)),
//         activityStatus: json["activityStatus"],
//         createdDate: json["createdDate"] == null
//             ? null
//             : DateTime.parse(json["createdDate"]),
//         modifiedDate: json["modifiedDate"] == null
//             ? null
//             : DateTime.parse(json["modifiedDate"]),
//         activityReligiousOffDates: json["activityReligiousOffDates"],
//         ageGroupDiscountPercent: json["ageGroupDiscountPercent"] == null
//             ? null
//             : AgeGroupDiscountPercent.fromJson(json["ageGroupDiscountPercent"]),
//         activityOfferMapping: json["activityOfferMapping"],
//         activityCategory: json["activityCategory"],
//       );

//   Map<String, dynamic> toJson() => {
//         "activityId": activityId,
//         "country": country,
//         "state": state,
//         "city": city,
//         "address": address,
//         "activityName": activityName,
//         "bestTimeToVisit": bestTimeToVisit,
//         "activityHours": activityHours,
//         "activityPrice": activityPrice,
//         "startTime": startTime,
//         "endTime": endTime,
//         "description": description,
//         "participantType": participantType == null
//             ? []
//             : List<dynamic>.from(participantType!.map((x) => x)),
//         "weeklyOff": weeklyOff == null
//             ? []
//             : List<dynamic>.from(weeklyOff!.map((x) => x)),
//         "activityImageUrl": activityImageUrl == null
//             ? []
//             : List<dynamic>.from(activityImageUrl!.map((x) => x)),
//         "activityStatus": activityStatus,
//         "createdDate": createdDate?.toIso8601String(),
//         "modifiedDate": modifiedDate?.toIso8601String(),
//         "activityReligiousOffDates": activityReligiousOffDates,
//         "ageGroupDiscountPercent": ageGroupDiscountPercent?.toJson(),
//         "activityOfferMapping": activityOfferMapping,
//         "activityCategory": activityCategory,
//       };
// }

// class AgeGroupDiscountPercent {
//   double? senior;
//   double? infant;
//   double? child;

//   AgeGroupDiscountPercent({
//     this.senior,
//     this.infant,
//     this.child,
//   });

//   factory AgeGroupDiscountPercent.fromJson(Map<String, dynamic> json) =>
//       AgeGroupDiscountPercent(
//         senior: json["SENIOR"],
//         infant: json["INFANT"],
//         child: json["CHILD"],
//       );

//   Map<String, dynamic> toJson() => {
//         "SENIOR": senior,
//         "INFANT": infant,
//         "CHILD": child,
//       };
// }

// class User {
//   int? userId;
//   String? firstName;
//   String? lastName;
//   String? mobile;
//   String? address;
//   String? email;
//   String? gender;
//   DateTime? createdDate;
//   DateTime? modifiedDate;
//   bool? status;
//   dynamic otp;
//   dynamic isOtpVerified;
//   String? userType;
//   String? profileImageUrl;
//   String? countryCode;
//   dynamic notificationToken;
//   String? lastLogin;
//   String? country;
//   String? state;
//   bool? accountVerified;

//   User({
//     this.userId,
//     this.firstName,
//     this.lastName,
//     this.mobile,
//     this.address,
//     this.email,
//     this.gender,
//     this.createdDate,
//     this.modifiedDate,
//     this.status,
//     this.otp,
//     this.isOtpVerified,
//     this.userType,
//     this.profileImageUrl,
//     this.countryCode,
//     this.notificationToken,
//     this.lastLogin,
//     this.country,
//     this.state,
//     this.accountVerified,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         userId: json["userId"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         mobile: json["mobile"],
//         address: json["address"],
//         email: json["email"],
//         gender: json["gender"],
//         createdDate: json["createdDate"] == null
//             ? null
//             : DateTime.parse(json["createdDate"]),
//         modifiedDate: json["modifiedDate"] == null
//             ? null
//             : DateTime.parse(json["modifiedDate"]),
//         status: json["status"],
//         otp: json["otp"],
//         isOtpVerified: json["isOtpVerified"],
//         userType: json["userType"],
//         profileImageUrl: json["profileImageUrl"],
//         countryCode: json["countryCode"],
//         notificationToken: json["notificationToken"],
//         lastLogin: json["lastLogin"],
//         country: json["country"],
//         state: json["state"],
//         accountVerified: json["accountVerified"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "firstName": firstName,
//         "lastName": lastName,
//         "mobile": mobile,
//         "address": address,
//         "email": email,
//         "gender": gender,
//         "createdDate": createdDate?.toIso8601String(),
//         "modifiedDate": modifiedDate?.toIso8601String(),
//         "status": status,
//         "otp": otp,
//         "isOtpVerified": isOtpVerified,
//         "userType": userType,
//         "profileImageUrl": profileImageUrl,
//         "countryCode": countryCode,
//         "notificationToken": notificationToken,
//         "lastLogin": lastLogin,
//         "country": country,
//         "state": state,
//         "accountVerified": accountVerified,
//       };
// }

// class Vehicle {
//   int? vehicleId;
//   String? carName;
//   int? year;
//   String? carType;
//   String? brandName;
//   String? fuelType;
//   int? seats;
//   String? color;
//   String? vehicleNumber;
//   String? modelNo;
//   DateTime? createdDate;
//   DateTime? modifiedDate;
//   List<String>? images;
//   String? vehicleStatus;
//   String? vehicleDocUrl;

//   Vehicle({
//     this.vehicleId,
//     this.carName,
//     this.year,
//     this.carType,
//     this.brandName,
//     this.fuelType,
//     this.seats,
//     this.color,
//     this.vehicleNumber,
//     this.modelNo,
//     this.createdDate,
//     this.modifiedDate,
//     this.images,
//     this.vehicleStatus,
//     this.vehicleDocUrl,
//   });

//   factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
//         vehicleId: json["vehicleId"],
//         carName: json["carName"],
//         year: json["year"],
//         carType: json["carType"],
//         brandName: json["brandName"],
//         fuelType: json["fuelType"],
//         seats: json["seats"],
//         color: json["color"],
//         vehicleNumber: json["vehicleNumber"],
//         modelNo: json["modelNo"],
//         createdDate: json["createdDate"] == null
//             ? null
//             : DateTime.parse(json["createdDate"]),
//         modifiedDate: json["modifiedDate"] == null
//             ? null
//             : DateTime.parse(json["modifiedDate"]),
//         images: json["images"] == null
//             ? []
//             : List<String>.from(json["images"]!.map((x) => x)),
//         vehicleStatus: json["vehicleStatus"],
//         vehicleDocUrl: json["vehicleDocUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "vehicleId": vehicleId,
//         "carName": carName,
//         "year": year,
//         "carType": carType,
//         "brandName": brandName,
//         "fuelType": fuelType,
//         "seats": seats,
//         "color": color,
//         "vehicleNumber": vehicleNumber,
//         "modelNo": modelNo,
//         "createdDate": createdDate?.toIso8601String(),
//         "modifiedDate": modifiedDate?.toIso8601String(),
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "vehicleStatus": vehicleStatus,
//         "vehicleDocUrl": vehicleDocUrl,
//       };
// }

// class Driver {
//   int? driverId;
//   String? firstName;
//   String? lastName;
//   String? driverAddress;
//   String? emiratesId;
//   String? mobile;
//   String? countryCode;
//   String? email;
//   String? gender;
//   String? licenceNumber;
//   DateTime? createdDate;
//   DateTime? modifiedDate;
//   String? profileImageUrl;
//   String? userType;
//   int? vendorId;
//   String? driverStatus;
//   dynamic notificationToken;
//   dynamic lastLogin;
//   String? state;
//   String? country;
//   dynamic verificationToken;
//   dynamic tokenExpiry;
//   bool? accountVerified;

//   Driver({
//     this.driverId,
//     this.firstName,
//     this.lastName,
//     this.driverAddress,
//     this.emiratesId,
//     this.mobile,
//     this.countryCode,
//     this.email,
//     this.gender,
//     this.licenceNumber,
//     this.createdDate,
//     this.modifiedDate,
//     this.profileImageUrl,
//     this.userType,
//     this.vendorId,
//     this.driverStatus,
//     this.notificationToken,
//     this.lastLogin,
//     this.state,
//     this.country,
//     this.verificationToken,
//     this.tokenExpiry,
//     this.accountVerified,
//   });

//   factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//         driverId: json["driverId"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         driverAddress: json["driverAddress"],
//         emiratesId: json["emiratesId"],
//         mobile: json["mobile"],
//         countryCode: json["countryCode"],
//         email: json["email"],
//         gender: json["gender"],
//         licenceNumber: json["licenceNumber"],
//         createdDate: json["createdDate"] == null
//             ? null
//             : DateTime.parse(json["createdDate"]),
//         modifiedDate: json["modifiedDate"] == null
//             ? null
//             : DateTime.parse(json["modifiedDate"]),
//         profileImageUrl: json["profileImageUrl"],
//         userType: json["userType"],
//         vendorId: json["vendorId"],
//         driverStatus: json["driverStatus"],
//         notificationToken: json["notificationToken"],
//         lastLogin: json["lastLogin"],
//         state: json["state"],
//         country: json["country"],
//         verificationToken: json["verificationToken"],
//         tokenExpiry: json["tokenExpiry"],
//         accountVerified: json["accountVerified"],
//       );

//   Map<String, dynamic> toJson() => {
//         "driverId": driverId,
//         "firstName": firstName,
//         "lastName": lastName,
//         "driverAddress": driverAddress,
//         "emiratesId": emiratesId,
//         "mobile": mobile,
//         "countryCode": countryCode,
//         "email": email,
//         "gender": gender,
//         "licenceNumber": licenceNumber,
//         "createdDate": createdDate?.toIso8601String(),
//         "modifiedDate": modifiedDate?.toIso8601String(),
//         "profileImageUrl": profileImageUrl,
//         "userType": userType,
//         "vendorId": vendorId,
//         "driverStatus": driverStatus,
//         "notificationToken": notificationToken,
//         "lastLogin": lastLogin,
//         "state": state,
//         "country": country,
//         "verificationToken": verificationToken,
//         "tokenExpiry": tokenExpiry,
//         "accountVerified": accountVerified,
//       };
// }

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
