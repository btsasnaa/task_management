import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controller/data_controller.dart';
import 'package:task_management/model/register_model.dart';
import 'package:task_management/screens/home_screen.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/show_custom_message.dart';
import 'package:task_management/widgets/button_widget.dart';
import 'package:task_management/widgets/text_filed_widget.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    DataController _dataController = Get.find<DataController>();
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    void _addTask() {
      String name = nameController.text.trim();
      String detail = detailController.text.trim();

      if (name.isEmpty) {
        showCustomerSnackBar("Type in task name", title: "Task name");
      } else if (detail.isEmpty) {
        showCustomerSnackBar("Type in task detail", title: "Task detail");
      } else {
        RegisterModel registerModel = RegisterModel(
          name: name,
          detail: detail,
        );
        _dataController.addTask(registerModel).then((status) {
          if (status.isSuccess) {
            print("success registration");
            loadData();

            Get.back();
          } else {
            showCustomerSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        // padding: EdgeInsets.only(left: 20, right: 20),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage("assets/image/welcome.png"),
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height / 3.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image/welcome.png"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextFieldWidget(
                    textController: nameController,
                    hintText: "Task name",
                  ),
                  SizedBox(height: 20),
                  TextFieldWidget(
                    textController: detailController,
                    hintText: "Task detail",
                    borderRadius: 15,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _addTask();
                    },
                    child: ButtonWidget(
                      backgroundColor: AppColors.mainColor,
                      text: "Add",
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
          ],
        ),
      ),
    );
  }
}
