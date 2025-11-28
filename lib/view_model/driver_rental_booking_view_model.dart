import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/get_rental_booking_by_id_model.dart';
import 'package:flutter_driver/data/models/rental_booking_model.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/respositories/driver_rental_repository.dart';
import 'package:flutter_driver/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverRentalBookingViewModel with ChangeNotifier {
  final _myRepo = DriverRentalBookingRepository();
  int pageNumber = 0;
  int pageSize = 10;
  bool isLastPage = false;
  bool isLoadingMore = false;
  ApiResponse<List<BookingContent>> bookingdataList = ApiResponse.initial();

  void setDataList(ApiResponse<List<BookingContent>> response) {
    bookingdataList = response;
    notifyListeners();
  }

  ApiResponse<GetRentalBookingByIdModel> bookingDetailsData =
      ApiResponse.initial();

  void setDataListById(ApiResponse<GetRentalBookingByIdModel> response) {
    bookingDetailsData = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> startAndCompleteResponse = ApiResponse.initial();

  void setStartAndComplete(ApiResponse<CommonModel> response) {
    startAndCompleteResponse = response;
    notifyListeners();
  }

  Future<void> fetchDriverGetBookingListViewModel(
      {required bool isFilter,
      required bool isPagination,
      required String filterText,
      int? pageNumer1,
      int? pageSize1}) async {
    if (isLoadingMore) return; // Prevent multiple calls

    if (!isPagination && isFilter) {
      pageNumber = 0;
      isLastPage = false;

      setDataList(ApiResponse.loading());
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {
      "driverId": driverId,
      "pageNumber": pageNumer1 ?? pageNumber,
      "pageSize": pageSize1 ?? pageSize,
      "bookingStatus": filterText
    };
    if (isLastPage) return;
    isLoadingMore = true;
    try {
      var resp = await _myRepo.driverBookingListRepositoryApi(query: query);
      List<BookingContent> newData = resp.data?.content ?? [];
      List<BookingContent> allData = (pageNumber == 0)
          ? newData
          : [...bookingdataList.data ?? [], ...newData];

      isLastPage = resp.data?.last ?? false;
      pageNumber++;

      setDataList(ApiResponse.completed(allData));
      debugPrint("Driver Booking List Success");
      // return resp;
    } catch (error) {
      setDataList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> getBookingDetailsApi({required String bookingId}) async {
    Map<String, dynamic> query = {"id": bookingId};
    try {
      setDataListById(ApiResponse.loading());
      var resp = await _myRepo.driverBookingDetailsRepositoryApi(query: query);
      setDataListById(ApiResponse.completed(resp));
    } catch (e) {
      setDataListById(ApiResponse.error(e.toString()));
    }
  }

  Future<CommonModel?> startAndCompleteBookingApi(
      {required String bookingId, required String bookingStatus}) async {
    Map<String, dynamic> query = {
      "id": bookingId,
      "bookingStatus": bookingStatus
    };
    try {
      setStartAndComplete(ApiResponse.loading());
      var resp = await _myRepo.bookingStartAndCompleteApi(query: query);
      setStartAndComplete(ApiResponse.completed(resp));
      Utils.toastSuccessMessage(resp.data?.body ?? '');
      return resp;
    } catch (e) {
      setStartAndComplete(ApiResponse.error(e.toString()));
    }
    return null;
  }
}
