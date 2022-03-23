import 'package:get/get.dart';
import 'package:task_management/model/register_model.dart';
import 'package:task_management/model/response_model.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/utils/data_service.dart';

class DataController extends GetxController {
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<TaskModel> _myData = [];
  List<TaskModel> get myData => _myData;

  Future<void> getData() async {
    _isLoading = true;
    Response response = await service.getData();
    if (response.statusCode == 200 && response.body["tasks"] != null) {
      // _myData = response.body["tasks"];
      _myData = [];
      response.body["tasks"].forEach((v) {
        print("task:" + v.toString());
        _myData.add(new TaskModel.fromJson(v));
      });

      print("we got data");
      update();
    } else {
      print("we did not get any data");
    }
  }

  Future<ResponseModel> addTask(RegisterModel registerModel) async {
    _isLoading = true;
    update();
    Response response = await service.addTask(registerModel.toJson());
    late ResponseModel responseModel;
    if (response.statusCode == 200 && response.body["error"] == null) {
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.body["error"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteTask(int id) async {
    _isLoading = true;
    update();
    Response response = await service.deleteTask({"id": id});
    late ResponseModel responseModel;
    if (response.statusCode == 200 && response.body["error"] == null) {
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.body["error"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
