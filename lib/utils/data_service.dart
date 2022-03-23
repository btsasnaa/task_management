import 'package:get/get.dart';
import 'package:task_management/utils/app_constants.dart';

class DataService extends GetConnect implements GetxService {
  Future<Response> getData() async {
    try {
      Response response = await get(
        AppConstants.BASE_URL + AppConstants.GET_TASK_URI,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> addTask(dynamic body) async {
    try {
      Response response = await post(
        AppConstants.BASE_URL + AppConstants.ADD_TASK_URI,
        body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteTask(dynamic body) async {
    try {
      Response response = await post(
        AppConstants.BASE_URL + AppConstants.DELETE_TASK_URI,
        body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
