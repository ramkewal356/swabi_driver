class AppUrl {
  // static var baseUrl = "http://swabi.ap-south-1.elasticbeanstalk.com";
  // static var baseUrlForImage = "http://swabi.ap-south-1.elasticbeanstalk.com";
  static var baseUrl = 'https://dev-api.swabitours.com';
  static var baseUrlForImage = "https://dev-api.swabitours.com";
  static var locationBaseUrl = 'https://www.universal-tutorial.com';

  ///registration URL
  static var login = "$baseUrl/login";
  static var driverlogin = "/login";

  static var rentalDriverBookingList =
      "$baseUrl/rental/get_rental_booking_by_driverId";
  static var rentalBooking = "$baseUrl/rental/booking";
  static var rentalBookingCancel = "$baseUrl/rental/cancel_rental_booking";
  static var rentalBookingList = "$baseUrl/rental/get_rental_booking_by_userId";
  static var rentalViewDetails = "$baseUrl/rental/get_rental_booking_by_id";
  static var driverProfile = "$baseUrl/rental/get_rental_booking_by_driverId";
  static var driverProfileUpdate = "$baseUrl/driver/update_driver_details";
  static var driverBookingList =
      "$baseUrl/rental/get_rental_booking_by_driverId";
  static var driverBookingDetails = "$baseUrl/rental/get_rental_booking_by_id";
  static var driverBookingListUrl =
      "/package_booking/get_package_booking_by_driver_id";
  static var driverBookingDetailListUrl =
      "/package_booking/get_assigned_package_booking_detail";
  static var driverActivityStartUrl = "/package_booking/start_activity";
  static var driverActivityCompleteUrl = "/package_booking/complete_activity";
  static var driverPackageHistoryUrl =
      "/package_booking/get_package_booking_history_by_driver_id";
  static var driverProfileUpdateEndUrl = "/driver/update_driver_details";
  static var raiseIssueUrl = "/booking_issue/raise_issue";
  static var getIssueUrl = "/booking_issue/get_issue_raised_by";
  static var getIssueDetailsUrl = "/booking_issue/get_issue_detail";
  static var changepasswordUrl = '/driver/change_driver_password';
  static var sendOtpsUrl = "/otp_send";
  static var verifyOtpUrl = "/otp_verify";
  static var resetPassordUrl = "/password_update";
  static var getIsseBybooking = '/booking_issue/get_issue_by_booking_id';
  static var updateNotificationStatusUrl =
      '/notification/update_notification_status';
  static var getAllNotificationUrl =
      '/notification/get_notification_by_receiverId';
  static var getDriverUrl = '/driver/get_driver_by_driverId';
  static var getRentalBookingByIdUrl = '/rental/get_rental_booking_by_id';
  static var getRentalBookingByDriverdUrl =
      '/rental/get_rental_booking_by_driverId';
  static var changeBookingStatus = '/rental/change_booking_status';
  static var uploadProfilePic = '/driver/upload_driver_profile_image';
  static var getCountryList = '/api/countries/';
  static var getStateList = '/api/states/';
  static var getAccessTokenUrl = '/api/getaccesstoken';
}
