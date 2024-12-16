///Driver Booking List All
class DriverBookingModel {
  Status status;
  Data data;

  DriverBookingModel({
    required this.status,
    required this.data,
  });

  factory DriverBookingModel.fromJson(Map<String, dynamic> json) =>
      DriverBookingModel(
        status: json["status"] != null
            ? Status.fromJson(json["status"])
            : Status(httpCode: "", success: false, message: ""),
        data: json["data"] != null
            ? Data.fromJson(json["data"])
            : Data(
                content: [],
                pageable: Pageable(
                    sort: Sort(sorted: false, empty: true, unsorted: true),
                    pageNumber: 0,
                    pageSize: 0,
                    offset: 0,
                    paged: false,
                    unpaged: true),
                totalPages: 0,
                totalElements: 0,
                last: false,
                size: 0,
                number: 0,
                sort: Sort(sorted: false, empty: true, unsorted: true),
                numberOfElements: 0,
                first: false,
                empty: true,
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  List<Content> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  Sort sort;
  int numberOfElements;
  bool first;
  bool empty;

  Data({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: json["content"] != null
            ? List<Content>.from(
                json["content"].map((x) => Content.fromJson(x)))
            : [],
        pageable: json["pageable"] != null
            ? Pageable.fromJson(json["pageable"])
            : Pageable(
                sort: Sort(sorted: false, empty: true, unsorted: true),
                pageNumber: 0,
                pageSize: 0,
                offset: 0,
                paged: false,
                unpaged: true,
              ),
        totalPages: json["totalPages"] ?? 0,
        totalElements: json["totalElements"] ?? 0,
        last: json["last"] ?? false,
        size: json["size"] ?? 0,
        number: json["number"] ?? 0,
        sort: json["sort"] != null
            ? Sort.fromJson(json["sort"])
            : Sort(sorted: false, empty: true, unsorted: true),
        numberOfElements: json["numberOfElements"] ?? 0,
        first: json["first"] ?? false,
        empty: json["empty"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "last": last,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
      };
}

class Content {
  String? id;
  String? rentalBookingId;
  String? date;
  String? pickupTime;
  String? locationLongitude;
  String? locationLatitude;
  String? bookingStatus;
  String? totalRentTime;
  String? kilometers;
  String? paidStatus;
  String? userId;
  String? rentalCharge;
  String? carType;
  String? extraMinutes;
  String? extraKilometers;
  String? createdDate;
  String? modifiedDate;
  String? rentalManagement;
  Vehicle? vehicle;
  Driver? driver;
  String? rideStartTime;
  String? rideEndTime;
  String? pickupLocation;
  String? cancellationReason;
  String? bookerId;
  String? bookingForId;
  DriverBookingUser? user;
  Guest? guest;
  String? cancelledBy;

  Content({
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
    this.rentalCharge,
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
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"]?.toString() ?? "",
        rentalBookingId: json["rentalBookingId"]?.toString() ?? "",
        date: json["date"]?.toString() ?? "",
        pickupTime: json["pickupTime"]?.toString() ?? "",
        locationLongitude: json["locationLongitude"]?.toString() ?? "",
        locationLatitude: json["locationLatitude"]?.toString() ?? "",
        bookingStatus: json["bookingStatus"]?.toString() ?? "",
        totalRentTime: json["totalRentTime"]?.toString() ?? "",
        kilometers: json["kilometers"]?.toString() ?? "",
        paidStatus: json["paidStatus"]?.toString() ?? "",
        userId: json["userId"]?.toString() ?? "",
        rentalCharge: json["rentalCharge"]?.toString() ?? "",
        carType: json["carType"]?.toString() ?? "",
        extraMinutes: json["extraMinutes"]?.toString() ?? "",
        extraKilometers: json["extraKilometers"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
        rentalManagement: json["rentalManagement"]?.toString() ?? "",
        vehicle: Vehicle.fromJson(json["vehicle"] ?? {}),
        // vehicle: json["vehicle"] != null ? Vehicle.fromJson(json["vehicle"] ?? {}) : Vehicle(
        //   vehicleId: "",
        //   carName: "",
        //   year: "",
        //   carType: "",
        //   brandName: "",
        //   fuelType: "",
        //   seats: "",
        //   color: "",
        //   vehicleNumber: "",
        //   modelNo: "",
        //   createdDate: "",
        //   modifiedDate: "",
        //   images: [],
        //   vehicleStatus: "",
        // ),
        driver: Driver.fromJson(json["driver"] ?? {}),
        // driver: json["driver"] != null ? Driver.fromJson(json["driver"] ?? {}) : Driver(
        //   driverId: "",
        //   firstName: "",
        //   lastName: "",
        //   driverAddress: "",
        //   emiratesId: "",
        //   mobile: "",
        //   countryCode: "",
        //   email: "",
        //   gender: "",
        //   licenceNumber: "",
        //   createdDate: "",
        //   modifiedDate: "",
        //   profileImageUrl: "",
        //   userType: "",
        //   vendorId: "",
        //   driverStatus: "",
        // ),
        rideStartTime: json["rideStartTime"]?.toString() ?? "",
        rideEndTime: json["rideEndTime"]?.toString() ?? "",
        pickupLocation: json["pickupLocation"] ?? "",
        cancellationReason: json["cancellationReason"]?.toString() ?? "",
        bookerId: json["bookerId"]?.toString() ?? "",
        bookingForId: json["bookingForId"]?.toString() ?? "",
        user: DriverBookingUser.fromJson(json["user"] ?? {}),
        // user: json["user"] != null ? DriverBookingUser.fromJson(json["user"] ?? {}) : DriverBookingUser(
        //   userId: "",
        //   firstName: "",
        //   lastName: "",
        //   mobile: "",
        //   address: "",
        //   email: "",
        //   gender: "",
        //   createdDate: "",
        //   modifiedDate: "",
        //   status: "",
        //   otp: "",
        //   isOtpVerified: "",
        //   userType: "",
        //   profileImageUrl: "",
        //   countryCode: "",
        // ),
        guest: Guest.fromJson(json["guest"] ?? {}),
        // guest: json["guest"] != null ? Guest.fromJson(json["guest"] ?? {}) : Guest(
        //   guestId: "",
        //   guestName: "",
        //   guestMobile: "",
        //   gender: "",
        //   userId: "",
        //   status: "",
        //   createdDate: "",
        //   modifiedDate: "",
        // ),
        cancelledBy: json["cancelledBy"]?.toString() ?? "",
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
        "rentalCharge": rentalCharge,
        "carType": carType,
        "extraMinutes": extraMinutes,
        "extraKilometers": extraKilometers,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "rentalManagement": rentalManagement,
        "vehicle": vehicle,
        "driver": driver,
        "rideStartTime": rideStartTime,
        "rideEndTime": rideEndTime,
        "pickupLocation": pickupLocation,
        "cancellationReason": cancellationReason,
        "bookerId": bookerId,
        "bookingForId": bookingForId,
        "user": user,
        "guest": guest,
        "cancelledBy": cancelledBy,
      };
}

class Guest {
  String? guestId;
  String? guestName;
  String? guestMobile;
  String? gender;
  String? userId;
  String? status;
  String? createdDate;
  String? modifiedDate;

  Guest({
    this.guestId,
    this.guestName,
    this.guestMobile,
    this.gender,
    this.userId,
    this.status,
    this.createdDate,
    this.modifiedDate,
  });

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        guestId: json["guestId"]?.toString() ?? "",
        guestName: json["guestName"]?.toString() ?? "",
        guestMobile: json["guestMobile"]?.toString() ?? "",
        gender: json["gender"]?.toString() ?? "",
        userId: json["userId"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "guestId": guestId,
        "guestName": guestName,
        "guestMobile": guestMobile,
        "gender": gender,
        "userId": userId,
        "status": status,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
      };
}

class Driver {
  String? driverId;
  String? firstName;
  String? lastName;
  String? driverAddress;
  String? emiratesId;
  String? mobile;
  String? countryCode;
  String? email;
  String? gender;
  String? licenceNumber;
  String? createdDate;
  String? modifiedDate;
  String? profileImageUrl;
  String? userType;
  String? vendorId;
  String? unavailableDates;
  String? driverStatus;

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
    this.unavailableDates,
    this.driverStatus,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driverId"]?.toString() ?? "",
        firstName: json["firstName"]?.toString() ?? "",
        lastName: json["lastName"]?.toString() ?? "",
        driverAddress: json["driverAddress"]?.toString() ?? "",
        emiratesId: json["emiratesId"]?.toString() ?? "",
        mobile: json["mobile"]?.toString() ?? "",
        countryCode: json["countryCode"]?.toString() ?? "",
        email: json["email"] ?? "",
        gender: json["gender"]?.toString() ?? "",
        licenceNumber: json["licenceNumber"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
        profileImageUrl: json["profileImageUrl"]?.toString() ?? "",
        userType: json["userType"]?.toString() ?? "",
        vendorId: json["vendorId"]?.toString() ?? "",
        unavailableDates: json["unavailableDates"]?.toString() ?? "",
        driverStatus: json["driverStatus"]?.toString() ?? "",
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
        "unavailableDates": unavailableDates,
        "driverStatus": driverStatus,
      };
}

class DriverBookingUser {
  String? userId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? address;
  String? email;
  String? gender;
  String? createdDate;
  String? modifiedDate;
  String? status;
  String? otp;
  String? isOtpVerified;
  String? userType;
  String? profileImageUrl;
  String? countryCode;

  DriverBookingUser({
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
  });

  factory DriverBookingUser.fromJson(Map<String, dynamic> json) =>
      DriverBookingUser(
        userId: json["userId"]?.toString() ?? "",
        firstName: json["firstName"]?.toString() ?? "",
        lastName: json["lastName"]?.toString() ?? "",
        mobile: json["mobile"]?.toString() ?? "",
        address: json["address"]?.toString() ?? "",
        email: json["email"]?.toString() ?? "",
        gender: json["gender"]?.toString() ?? "",
        createdDate: json["createdDate"]?.toString() ?? "",
        modifiedDate: json["modifiedDate"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
        otp: json["otp"]?.toString() ?? "",
        isOtpVerified: json["isOtpVerified"]?.toString() ?? "",
        userType: json["userType"]?.toString() ?? "",
        profileImageUrl: json["profileImageUrl"]?.toString() ?? "",
        countryCode: json["countryCode"]?.toString() ?? "",
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

class Vehicle {
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
  String? unavailableDates;

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
    this.unavailableDates,
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
        images: List<String>.from(json["images"].map((x) => x)),
        // images: json["images"] != null && json["images"].isNotEmpty
        //     ? List<String>.from(json["images"].map((x) => x))
        //     : [],
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
        "images": List<dynamic>.from(images!.map((x) => x)),
        "vehicleStatus": vehicleStatus,
        "unavailableDates": unavailableDates,
      };
}

class Pageable {
  Sort sort;
  int pageNumber;
  int pageSize;
  int offset;
  bool paged;
  bool unpaged;

  Pageable({
    required this.sort,
    required this.pageNumber,
    required this.pageSize,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  bool sorted;
  bool empty;
  bool unsorted;

  Sort({
    required this.sorted,
    required this.empty,
    required this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        empty: json["empty"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "empty": empty,
        "unsorted": unsorted,
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

///Get Driver Booking Details Single By Booking Id
class DriverGetBookingDetailsModel {
  DriverGetBookingDetailsStatus status;
  DriverGetBookingDetailsData data;

  DriverGetBookingDetailsModel({
    required this.status,
    required this.data,
  });

  factory DriverGetBookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      DriverGetBookingDetailsModel(
        status: DriverGetBookingDetailsStatus.fromJson(json["status"]),
        data: DriverGetBookingDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverGetBookingDetailsData {
  String id;
  String rentalBookingId;
  String date;
  String pickupTime;
  String locationLongitude;
  String locationLatitude;
  String bookingStatus;
  String totalRentTime;
  String kilometers;
  String paidStatus;
  String userId;
  String rentalCharge;
  String carType;
  String extraMinutes;
  String extraKilometers;
  String createdDate;
  String modifiedDate;
  String rentalManagement;
  DriverGetBookingDetailsVehicle vehicle;
  DriverGetBookingDetailsDriver driver;
  String rideStartTime;
  String rideEndTime;
  String pickupLocation;
  String cancellationReason;
  User user;
  DriverGetBookingDetailsGuest driverGetBookingDetailsGuest;
  String? cancelledBy;

  DriverGetBookingDetailsData({
    required this.id,
    required this.rentalBookingId,
    required this.date,
    required this.pickupTime,
    required this.locationLongitude,
    required this.locationLatitude,
    required this.bookingStatus,
    required this.totalRentTime,
    required this.kilometers,
    required this.paidStatus,
    required this.userId,
    required this.rentalCharge,
    required this.carType,
    required this.extraMinutes,
    required this.extraKilometers,
    required this.createdDate,
    required this.modifiedDate,
    required this.rentalManagement,
    required this.vehicle,
    required this.driver,
    required this.rideStartTime,
    required this.rideEndTime,
    required this.pickupLocation,
    required this.cancellationReason,
    required this.user,
    required this.driverGetBookingDetailsGuest,
    required this.cancelledBy,
  });

  factory DriverGetBookingDetailsData.fromJson(Map<String, dynamic> json) =>
      DriverGetBookingDetailsData(
        id: json["id"].toString(),
        rentalBookingId: json["rentalBookingId"] ?? '',
        date: json["date"] ?? '',
        pickupTime: json["pickupTime"] ?? '',
        locationLongitude: json["locationLongitude"].toString(),
        locationLatitude: json["locationLatitude"].toString(),
        bookingStatus: json["bookingStatus"] ?? '',
        totalRentTime: json["totalRentTime"].toString(),
        kilometers: json["kilometers"].toString(),
        paidStatus: json["paidStatus"].toString(),
        userId: json["userId"] ?? "",
        rentalCharge: json["rentalCharge"].toString(),
        carType: json["carType"] ?? '',
        extraMinutes: json["extraMinutes"].toString(),
        extraKilometers: json["extraKilometers"].toString(),
        createdDate: json["createdDate"].toString(),
        modifiedDate: json["modifiedDate"].toString(),
        rentalManagement: json["rentalManagement"].toString(),
        vehicle: DriverGetBookingDetailsVehicle.fromJson(json["vehicle"] ?? {}),
        driver: DriverGetBookingDetailsDriver.fromJson(json["driver"] ?? {}),
        rideStartTime: json["rideStartTime"] ?? '',
        rideEndTime: json["rideEndTime"] ?? '',
        pickupLocation: json["pickupLocation"] ?? '',
        cancellationReason: json["cancellationReason"] ?? '',
        user: User.fromJson(json["user"] ?? {}),
        driverGetBookingDetailsGuest: DriverGetBookingDetailsGuest.fromJson(
            json["driverGetBookingDetailsGuest"] ?? {}),
        cancelledBy: json["cancelledBy"]?.toString() ?? '',
      );

  get guestName => null;

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
        "rentalCharge": rentalCharge,
        "carType": carType,
        "extraMinutes": extraMinutes,
        "extraKilometers": extraKilometers,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "rentalManagement": rentalManagement,
        "vehicle": vehicle,
        "driver": driver,
        "rideStartTime": rideStartTime,
        "rideEndTime": rideEndTime,
        "pickupLocation": pickupLocation,
        "cancellationReason": cancellationReason,
        "user": user,
        "driverGetBookingDetailsGuest": driverGetBookingDetailsGuest,
        "cancelledBy": cancelledBy,
      };
}

class DriverGetBookingDetailsDriver {
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
  String driverStatus;

  DriverGetBookingDetailsDriver({
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
    required this.driverStatus,
  });

  factory DriverGetBookingDetailsDriver.fromJson(Map<String, dynamic> json) =>
      DriverGetBookingDetailsDriver(
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
        "driverStatus": driverStatus,
      };
}

///Guest Details
class DriverGetBookingDetailsGuest {
  String guestId;
  String guestName;
  String countryCode;
  String guestMobile;
  String gender;
  String userId;
  bool status;
  String createdDate;
  String modifiedDate;

  DriverGetBookingDetailsGuest({
    required this.guestId,
    required this.guestName,
    required this.countryCode,
    required this.guestMobile,
    required this.gender,
    required this.userId,
    required this.status,
    required this.createdDate,
    required this.modifiedDate,
  });

  factory DriverGetBookingDetailsGuest.fromJson(Map<String, dynamic> json) =>
      DriverGetBookingDetailsGuest(
        guestId: json["guestId"].toString(),
        guestName: json["guestName"] ?? "",
        countryCode: json["countryCode"] ?? "",
        guestMobile: json["guestMobile"] ?? "",
        gender: json["gender"] ?? "",
        userId: json["userId"].toString(),
        status: json["status"] ?? false,
        createdDate: json["createdDate"].toString(),
        modifiedDate: json["modifiedDate"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "guestId": guestId,
        "guestName": guestName,
        "countryCode": countryCode,
        "guestMobile": guestMobile,
        "gender": gender,
        "userId": userId,
        "status": status,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
      };
}

class User {
  String userId;
  String firstName;
  String lastName;
  String countryCode;
  String mobile;
  String address;
  String email;
  String gender;
  String createdDate;
  String modifiedDate;
  String status;
  String otp;
  String isOtpVerified;
  String userType;
  String profileImageUrl;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"].toString(),
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        countryCode: json["countryCode"] ?? '',
        mobile: json["mobile"] ?? '',
        address: json["address"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        createdDate: json["createdDate"].toString(),
        modifiedDate: json["modifiedDate"].toString(),
        status: json["status"].toString(),
        otp: json["otp"].toString(),
        isOtpVerified: json["isOtpVerified"].toString(),
        userType: json["userType"] ?? '',
        profileImageUrl: json["profileImageUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "countryCode": countryCode,
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
      };
}

class DriverGetBookingDetailsVehicle {
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
  List<dynamic> images;
  String vehicleStatus;
  // List<dynamic> unavailableDates;

  DriverGetBookingDetailsVehicle({
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
    // required this.unavailableDates,
  });

  factory DriverGetBookingDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      DriverGetBookingDetailsVehicle(
        vehicleId: json["vehicleId"].toString(),
        carName: json["carName"] ?? '',
        year: json["year"].toString(),
        carType: json["carType"] ?? '',
        brandName: json["brandName"] ?? '',
        fuelType: json["fuelType"] ?? '',
        seats: json["seats"].toString(),
        color: json["color"] ?? '',
        vehicleNumber: json["vehicleNumber"] ?? '',
        modelNo: json["modelNo"] ?? '',
        createdDate: json["createdDate"].toString(),
        modifiedDate: json["modifiedDate"].toString(),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        vehicleStatus: json["vehicleStatus"] ?? '',
        // unavailableDates: List<dynamic>.from(json["unavailableDates"].map((x) => x)),
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
        // "unavailableDates": List<dynamic>.from(unavailableDates.map((x) => x)),
      };
}

class DriverGetBookingDetailsStatus {
  String httpCode;
  String success;
  String message;

  DriverGetBookingDetailsStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverGetBookingDetailsStatus.fromJson(Map<String, dynamic> json) =>
      DriverGetBookingDetailsStatus(
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

///Driver Start Ride Booking Model
class DriverOnRunningModel {
  DriverOnRunningStatus status;
  DriverOnRunningData data;

  DriverOnRunningModel({
    required this.status,
    required this.data,
  });

  factory DriverOnRunningModel.fromJson(Map<String, dynamic> json) =>
      DriverOnRunningModel(
        status: DriverOnRunningStatus.fromJson(json["status"]),
        data: DriverOnRunningData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverOnRunningData {
  Headers headers;
  String body;
  String statusCode;
  String statusCodeValue;

  DriverOnRunningData({
    required this.headers,
    required this.body,
    required this.statusCode,
    required this.statusCodeValue,
  });

  factory DriverOnRunningData.fromJson(Map<String, dynamic> json) =>
      DriverOnRunningData(
        headers: Headers.fromJson(json["headers"]),
        body: json["body"] ?? '',
        statusCode: json["statusCode"] ?? '',
        statusCodeValue: json["statusCodeValue"].toString(),
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

class DriverOnRunningStatus {
  String httpCode;
  bool success;
  String message;

  DriverOnRunningStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverOnRunningStatus.fromJson(Map<String, dynamic> json) =>
      DriverOnRunningStatus(
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

///Driver Booking Completed Model
class DriverBookingCompletedModel {
  DriverBookingCompletedStatus status;
  DriverBookingCompletedData data;

  DriverBookingCompletedModel({
    required this.status,
    required this.data,
  });

  factory DriverBookingCompletedModel.fromJson(Map<String, dynamic> json) =>
      DriverBookingCompletedModel(
        status: DriverBookingCompletedStatus.fromJson(json["status"]),
        data: DriverBookingCompletedData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class DriverBookingCompletedData {
  Headers headers;
  String body;
  String statusCode;
  String statusCodeValue;

  DriverBookingCompletedData({
    required this.headers,
    required this.body,
    required this.statusCode,
    required this.statusCodeValue,
  });

  factory DriverBookingCompletedData.fromJson(Map<String, dynamic> json) =>
      DriverBookingCompletedData(
        headers: Headers.fromJson(json["headers"]),
        body: json["body"] ?? '',
        statusCode: json["statusCode"] ?? '',
        statusCodeValue: json["statusCodeValue"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "headers": headers.toJson(),
        "body": body,
        "statusCode": statusCode,
        "statusCodeValue": statusCodeValue,
      };
}

class DriverBookingCompletedHeaders {
  DriverBookingCompletedHeaders();

  factory DriverBookingCompletedHeaders.fromJson(Map<String, dynamic> json) =>
      DriverBookingCompletedHeaders();

  Map<String, dynamic> toJson() => {};
}

class DriverBookingCompletedStatus {
  String httpCode;
  String success;
  String message;

  DriverBookingCompletedStatus({
    required this.httpCode,
    required this.success,
    required this.message,
  });

  factory DriverBookingCompletedStatus.fromJson(Map<String, dynamic> json) =>
      DriverBookingCompletedStatus(
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
