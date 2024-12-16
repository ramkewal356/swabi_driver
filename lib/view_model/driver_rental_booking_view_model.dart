import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/model/driver_booking_model.dart';
import 'package:flutter_driver/respository/driver_rental_repository.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DriverGetBookingListViewModel with ChangeNotifier {
  final _myRepo = DriverRentalBookingListRepository();
  ApiResponse<DriverBookingModel> DataList = ApiResponse.loading();
  ApiResponse<DriverBookingModel> DataList1 = ApiResponse.loading();
  ApiResponse<DriverBookingModel> DataList2 = ApiResponse.loading();
  ApiResponse<DriverBookingModel> DataList3 = ApiResponse.loading();

  setDataList(ApiResponse<DriverBookingModel> response) {
    DataList = response;
    notifyListeners();
  }

  setDataList1(ApiResponse<DriverBookingModel> response) {
    DataList1 = response;
    notifyListeners();
  }

  setDataList2(ApiResponse<DriverBookingModel> response) {
    DataList2 = response;
    notifyListeners();
  }

  setDataList3(ApiResponse<DriverBookingModel> response) {
    DataList3 = response;
    notifyListeners();
  }

  Future<DriverBookingModel?> fetchDriverGetBookingListViewModel(
      data, BuildContext context) async {
    try {
      setDataList(ApiResponse.loading());
      var resp = await _myRepo.driverBookingListRepositoryApi(
          context: context, query: data);
      setDataList(ApiResponse.completed(resp));
      print("Driver Booking List Success");
      return resp;
    } catch (error) {
      setDataList(ApiResponse.error(error.toString()));
      print(error.toString());
    }
    return null;
    // _myRepo.driverBookingListRepositoryApi(data).then((value) {
    //   setDataList(ApiResponse.completed(value));
    //   print("Driver Booking List Success");
    //   // Utils.toastMessage("Driver Booking ALL List Successfull");
    // }).onError((error, stackTrace) {
    //   setDataList(ApiResponse.error(error.toString()));
    //   print(error.toString());
    //   // Utils.flushBarErrorMessage(error.toString(),context);
    // });
  }

  Future fetchDriverGetBookingListViewModel1(data, BuildContext context) async {
    setDataList1(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) {
      setDataList1(ApiResponse.completed(value));
      print("Driver Booking List Success");
      // Utils.toastMessage("Driver Booking UP_RUNNING List Successfull");
    }).onError((error, stackTrace) {
      setDataList1(ApiResponse.error(error.toString()));
      print(error.toString());
      // Utils.flushBarErrorMessage(error.toString(),context);
    });
  }

  Future fetchDriverGetBookingListViewModel2(data, BuildContext context) async {
    setDataList2(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) {
      setDataList2(ApiResponse.completed(value));
      print("Driver Booking List Success");
      // Utils.toastMessage("Driver Booking BOOKED List Successfull");
    }).onError((error, stackTrace) {
      setDataList2(ApiResponse.error(error.toString()));
      print(error.toString());
      // Utils.flushBarErrorMessage(error.toString(),context);
    });
  }

  Future fetchDriverGetBookingListViewModel3(data, BuildContext context) async {
    setDataList3(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) {
      setDataList3(ApiResponse.completed(value));
      print("Driver Booking List Success");
      // Utils.toastMessage("Driver Booking BOOKED List Successfull");
    }).onError((error, stackTrace) {
      setDataList3(ApiResponse.error(error.toString()));
      print(error.toString());
      // Utils.flushBarErrorMessage(error.toString(),context);
    });
  }
}

///Driver Get Booking Details Single Full View Model
class DriverGetBookingDetailsViewModel with ChangeNotifier {
  final _myRepo = DriverRentalBookingDetailsRepository();
  ApiResponse<DriverGetBookingDetailsModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<DriverGetBookingDetailsModel> response) {
    DataList = response;
    notifyListeners();
  }

  void updateBookingStatus(String newStatus) {
    if (DataList.data?.data != null) {
      DataList.data?.data.bookingStatus = newStatus;
      notifyListeners();
    }
  }

  Future fetchDriverGetBookingDetailsViewModel(
      data, BuildContext context, String bookID, String myIdDriver) async {
    setDataList(ApiResponse.loading());
    _myRepo
        .driverBookingDetailsRepositoryApi(context: context, query: data)
        .then((value) {
      setDataList(ApiResponse.completed(value));
      print("Driver Booking Details Success");
      context.push('/bookingDetails',
          extra: {'bookId': bookID, 'myDriverId': myIdDriver}).then((value) {
        Provider.of<DriverGetBookingListViewModel>(context, listen: false)
            .fetchDriverGetBookingListViewModel({
          "driverId": myIdDriver,
          "pageNumber": "0",
          "pageSize": "5",
          "bookingStatus": "BOOKED"
        }, context);
      });
      // Utils.toastMessage("Driver Booking Details Successful");
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      print(error.toString());
      // Utils.flushBarErrorMessage(error.toString(),context);
    });
  }
}

///Driver On Running Ride View Model
class DriverOnRunningViewModel with ChangeNotifier {
  final _myRepo = DriverOnRunningRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<DriverOnRunningModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<DriverOnRunningModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future fetchDriverStartRideViewModel(
      data, BuildContext context, String bookId, String drvID) async {
    setLoading(true);

    setDataList(ApiResponse.loading());
    _myRepo
        .driverOnRunningRepositoryApi(context: context, query: data)
        .then((value) {
      setLoading(false);
      setDataList(ApiResponse.completed(value));
      print("Driver On Going Success");
      context.pop();
      // Provider.of<DriverOnRunningViewModel>(context,listen: false).
      // fetchDriverStartRideViewModel({
      //   "id": bookId,
      //   "bookingStatus":"ON_RUNNING"
      // },context,bookId,drvID);
      // context.replace('/bookingDetails',extra: {'bookId': bookId,'myDriverId':drvID});
      // context.replace('/onRunning_DetailsPage',
      //     extra: {'bookId': bookId, 'driverID': drvID});
      Utils.toastSuccessMessage("Driver Ongoing Successfully");
    }).onError((error, stackTrace) {
      setLoading(false);
      setDataList(ApiResponse.error(error.toString()));
      print("Driver On Running field");
      print(error.toString());
      Utils.toastMessage(error.toString());
    });
  }
}

///Driver Start Ride View Model
class DriverCompletedBookingViewModel with ChangeNotifier {
  final _myRepo = DriverBookingCompletedRepository();
  bool _loading = false;
  bool get loading => _loading;
  ApiResponse<DriverBookingCompletedModel> DataList = ApiResponse.loading();

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setDataList(ApiResponse<DriverBookingCompletedModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future fetchDriverBookingCompletedViewModel(
      data, BuildContext context, String driverId) async {
    setLoading(true);

    setDataList(ApiResponse.loading());
    _myRepo
        .driverDriverBookingCompletedRepositoryApi(
            context: context, query: data)
        .then((value) {
      setLoading(false);
      setDataList(ApiResponse.completed(value));
      context.pop();
      print("Driver Booking Completed Successfully");
      Provider.of<DriverGetBookingListViewModel>(context, listen: false)
          .fetchDriverGetBookingListViewModel({
        "driverId": driverId,
        "pageNumber": "0",
        "pageSize": "10",
        "bookingStatus": "BOOKED"
      }, context);
      context.go('/');
      Utils.toastSuccessMessage("Booking has been Completed Successfully");
    }).onError((error, stackTrace) {
      setLoading(false);
      setDataList(ApiResponse.error(error.toString()));
      print("Driver Booking Completed field");
      print(error.toString());
      // Utils.flushBarErrorMessage(error.toString(),context);
    });
  }
}
