// To parse this JSON data, do
//
//     final rentalBookingModel = rentalBookingModelFromJson(jsonString);

import 'dart:convert';

RentalBookingModel rentalBookingModelFromJson(String str) =>
    RentalBookingModel.fromJson(json.decode(str));

String rentalBookingModelToJson(RentalBookingModel data) =>
    json.encode(data.toJson());

class RentalBookingModel {
  Status? status;
  Data? data;

  RentalBookingModel({
    this.status,
    this.data,
  });

  factory RentalBookingModel.fromJson(Map<String, dynamic> json) =>
      RentalBookingModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<BookingContent>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? number;
  Sort? sort;
  int? size;
  int? numberOfElements;
  bool? first;
  bool? empty;

  Data({
    this.content,
    this.pageable,
    this.totalElements,
    this.totalPages,
    this.last,
    this.number,
    this.sort,
    this.size,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"] == null
            ? []
            : List<BookingContent>.from(
                json["content"]!.map((x) => BookingContent.fromJson(x))),
        pageable: json["pageable"] == null
            ? null
            : Pageable.fromJson(json["pageable"]),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        last: json["last"],
        number: json["number"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        size: json["size"],
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
        "pageable": pageable?.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "last": last,
        "number": number,
        "sort": sort?.toJson(),
        "size": size,
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
      };
}

class BookingContent {
  int? id;
  String? rentalBookingId;
  String? date;
  String? pickupTime;
  double? locationLongitude;
  double? locationLatitude;
  String? bookingStatus;
  int? totalRentTime;
  int? kilometers;
  bool? paidStatus;
  dynamic userId;
  String? carType;
  dynamic extraMinutes;
  dynamic extraKilometers;
  int? createdDate;
  int? modifiedDate;
  dynamic rentalManagement;
  Vehicle? vehicle;
  Driver? driver;
  dynamic rideStartTime;
  dynamic rideEndTime;
  String? pickupLocation;
  dynamic cancellationReason;
  int? bookerId;
  int? bookingForId;
  User? user;
  dynamic guest;
  dynamic cancelledBy;
  dynamic paymentId;
  String? offerCode;
  double? rentalCharge;
  double? taxAmount;
  double? taxPercentage;
  double? discountAmount;
  double? totalPayableAmount;
  int? vendorId;

  BookingContent({
    this.id,
    this.rentalBookingId,
    this.date,
    this.pickupTime,
    this.locationLongitude,
    this.locationLatitude,
    this.bookingStatus,
    this.totalRentTime,
    this.kilometers,
    this.paidStatus,
    this.userId,
    this.carType,
    this.extraMinutes,
    this.extraKilometers,
    this.createdDate,
    this.modifiedDate,
    this.rentalManagement,
    this.vehicle,
    this.driver,
    this.rideStartTime,
    this.rideEndTime,
    this.pickupLocation,
    this.cancellationReason,
    this.bookerId,
    this.bookingForId,
    this.user,
    this.guest,
    this.cancelledBy,
    this.paymentId,
    this.offerCode,
    this.rentalCharge,
    this.taxAmount,
    this.taxPercentage,
    this.discountAmount,
    this.totalPayableAmount,
    this.vendorId,
  });

  factory BookingContent.fromJson(Map<String, dynamic> json) => BookingContent(
        id: json["id"],
        rentalBookingId: json["rentalBookingId"],
        date: json["date"],
        pickupTime: json["pickupTime"],
        locationLongitude: json["locationLongitude"]?.toDouble(),
        locationLatitude: json["locationLatitude"]?.toDouble(),
        bookingStatus: json["bookingStatus"],
        totalRentTime: json["totalRentTime"],
        kilometers: json["kilometers"],
        paidStatus: json["paidStatus"],
        userId: json["userId"],
        carType: json["carType"],
        extraMinutes: json["extraMinutes"],
        extraKilometers: json["extraKilometers"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        rentalManagement: json["rentalManagement"],
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        rideStartTime: json["rideStartTime"],
        rideEndTime: json["rideEndTime"],
        pickupLocation: json["pickupLocation"],
        cancellationReason: json["cancellationReason"],
        bookerId: json["bookerId"],
        bookingForId: json["bookingForId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        guest: json["guest"],
        cancelledBy: json["cancelledBy"],
        paymentId: json["paymentId"],
        offerCode: json["offerCode"],
        rentalCharge: json["rentalCharge"],
        taxAmount: json["taxAmount"],
        taxPercentage: json["taxPercentage"],
        discountAmount: json["discountAmount"],
        totalPayableAmount: json["totalPayableAmount"],
        vendorId: json["vendorId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rentalBookingId": rentalBookingId,
        "date": date,
        "pickupTime": pickupTime,
        "locationLongitude": locationLongitude,
        "locationLatitude": locationLatitude,
        "bookingStatus": bookingStatus,
        "totalRentTime": totalRentTime,
        "kilometers": kilometers,
        "paidStatus": paidStatus,
        "userId": userId,
        "carType": carType,
        "extraMinutes": extraMinutes,
        "extraKilometers": extraKilometers,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "rentalManagement": rentalManagement,
        "vehicle": vehicle?.toJson(),
        "driver": driver?.toJson(),
        "rideStartTime": rideStartTime,
        "rideEndTime": rideEndTime,
        "pickupLocation": pickupLocation,
        "cancellationReason": cancellationReason,
        "bookerId": bookerId,
        "bookingForId": bookingForId,
        "user": user?.toJson(),
        "guest": guest,
        "cancelledBy": cancelledBy,
        "paymentId": paymentId,
        "offerCode": offerCode,
        "rentalCharge": rentalCharge,
        "taxAmount": taxAmount,
        "taxPercentage": taxPercentage,
        "discountAmount": discountAmount,
        "totalPayableAmount": totalPayableAmount,
        "vendorId": vendorId,
      };
}

class Driver {
  int? driverId;
  String? firstName;
  String? lastName;
  String? driverAddress;
  String? emiratesId;
  String? mobile;
  String? countryCode;
  String? email;
  String? gender;
  String? licenceNumber;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? profileImageUrl;
  String? userType;
  int? vendorId;
  String? driverStatus;
  String? notificationToken;
  String? lastLogin;
  String? state;
  String? country;
  dynamic verificationToken;
  dynamic tokenExpiry;
  bool? accountVerified;

  Driver({
    this.driverId,
    this.firstName,
    this.lastName,
    this.driverAddress,
    this.emiratesId,
    this.mobile,
    this.countryCode,
    this.email,
    this.gender,
    this.licenceNumber,
    this.createdDate,
    this.modifiedDate,
    this.profileImageUrl,
    this.userType,
    this.vendorId,
    this.driverStatus,
    this.notificationToken,
    this.lastLogin,
    this.state,
    this.country,
    this.verificationToken,
    this.tokenExpiry,
    this.accountVerified,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driverId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        driverAddress: json["driverAddress"],
        emiratesId: json["emiratesId"],
        mobile: json["mobile"],
        countryCode: json["countryCode"],
        email: json["email"],
        gender: json["gender"],
        licenceNumber: json["licenceNumber"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null
            ? null
            : DateTime.parse(json["modifiedDate"]),
        profileImageUrl: json["profileImageUrl"],
        userType: json["userType"],
        vendorId: json["vendorId"],
        driverStatus: json["driverStatus"],
        notificationToken: json["notificationToken"],
        lastLogin: json["lastLogin"],
        state: json["state"],
        country: json["country"],
        verificationToken: json["verificationToken"],
        tokenExpiry: json["tokenExpiry"],
        accountVerified: json["accountVerified"],
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
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "profileImageUrl": profileImageUrl,
        "userType": userType,
        "vendorId": vendorId,
        "driverStatus": driverStatus,
        "notificationToken": notificationToken,
        "lastLogin": lastLogin,
        "state": state,
        "country": country,
        "verificationToken": verificationToken,
        "tokenExpiry": tokenExpiry,
        "accountVerified": accountVerified,
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
  dynamic profileImageUrl;
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

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort?.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
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
