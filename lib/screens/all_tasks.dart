import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controller/data_controller.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/show_custom_message.dart';
import 'package:task_management/widgets/button_widget.dart';
import 'package:task_management/widgets/task_widget.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    DataController _dataController = Get.find<DataController>();
    List<TaskModel> _myData = _dataController.myData;

    final leftEditIcon = Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Color(0xFF2e3253).withOpacity(0.5),
      child: Icon(
        color: Colors.white,
        Icons.edit,
      ),
      alignment: Alignment.centerLeft,
    );
    final rightDeleteIcon = Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.redAccent,
      child: Icon(
        color: Colors.white,
        Icons.delete,
      ),
      alignment: Alignment.centerRight,
    );

    void loadData() async {
      await _dataController.getData();
    }

    void _deleteTask(int id) {
      _dataController.deleteTask(id).then((status) {
        if (status.isSuccess) {
          print("success delete");
        } else {
          showCustomerSnackBar(status.message);
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, top: 60),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.secondaryColor,
              ),
            ),
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
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Icon(
                  Icons.home,
                  color: AppColors.secondaryColor,
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.add_circle,
                  color: AppColors.mainColor,
                  size: 25,
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.calendar_month,
                  color: AppColors.secondaryColor,
                ),
                SizedBox(width: 10),
                Text(
                  _myData.length.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: _myData.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: leftEditIcon,
                    secondaryBackground: rightDeleteIcon,
                    onDismissed: (DismissDirection direction) {
                      print("after dismiss");
                      _deleteTask(_myData[index].id!);
                      setState(() {
                        _myData.removeAt(index);
                      });
                    },
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (_) {
                              return Container(
                                height: 500,
                                decoration: BoxDecoration(
                                  color: AppColors.modalGrey.withOpacity(0.4),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ButtonWidget(
                                        backgroundColor: AppColors.mainColor,
                                        text: "View",
                                        textColor: Colors.white,
                                      ),
                                      SizedBox(height: 20),
                                      ButtonWidget(
                                        backgroundColor: AppColors.mainColor,
                                        text: "Edit",
                                        textColor: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                        return false;
                      } else {
                        return Future.delayed(Duration(milliseconds: 500),
                            () => direction == DismissDirection.endToStart);
                      }
                    },
                    // key: ObjectKey(index),
                    key: UniqueKey(),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: TaskWidget(
                        text: _myData[index].name!,
                        color: Colors.blueGrey,
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

// class AllTasks extends StatelessWidget {
//   const AllTasks({Key? key}) : super(key: key);

//   loadData() async {
//     await Get.find<DataController>().getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     DataController _dataController = Get.find<DataController>();
//     List<TaskModel> _myData = _dataController.myData;

//     final leftEditIcon = Container(
//       margin: EdgeInsets.only(bottom: 10),
//       color: Color(0xFF2e3253).withOpacity(0.5),
//       child: Icon(
//         color: Colors.white,
//         Icons.edit,
//       ),
//       alignment: Alignment.centerLeft,
//     );
//     final rightDeleteIcon = Container(
//       margin: EdgeInsets.only(bottom: 10),
//       color: Colors.redAccent,
//       child: Icon(
//         color: Colors.white,
//         Icons.delete,
//       ),
//       alignment: Alignment.centerRight,
//     );

//     void _deleteTask(int id) {
//       _dataController.deleteTask(id).then((status) {
//         if (status.isSuccess) {
//           print("success registration");
//           loadData();
//         } else {
//           showCustomerSnackBar(status.message);
//         }
//       });
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Container(
//             alignment: Alignment.topLeft,
//             padding: EdgeInsets.only(left: 20, top: 60),
//             child: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: Icon(
//                 Icons.arrow_back,
//                 color: AppColors.secondaryColor,
//               ),
//             ),
//             width: double.maxFinite,
//             height: MediaQuery.of(context).size.height / 3.2,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage("assets/image/welcome.png"),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 20, right: 20),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.home,
//                   color: AppColors.secondaryColor,
//                 ),
//                 SizedBox(width: 10),
//                 Icon(
//                   Icons.add_circle,
//                   color: AppColors.mainColor,
//                   size: 25,
//                 ),
//                 Expanded(child: Container()),
//                 Icon(
//                   Icons.calendar_month,
//                   color: AppColors.secondaryColor,
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   _myData.length.toString(),
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: AppColors.secondaryColor,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Flexible(
//             child: ListView.builder(
//                 itemCount: _myData.length,
//                 itemBuilder: (context, index) {
//                   return Dismissible(
//                     background: leftEditIcon,
//                     secondaryBackground: rightDeleteIcon,
//                     onDismissed: (DismissDirection direction) {
//                       print("after dismiss");
//                       _deleteTask(_myData[index].id!);
//                     },
//                     confirmDismiss: (DismissDirection direction) async {
//                       if (direction == DismissDirection.startToEnd) {
//                         showModalBottomSheet(
//                             backgroundColor: Colors.transparent,
//                             barrierColor: Colors.transparent,
//                             context: context,
//                             builder: (_) {
//                               return Container(
//                                 height: 500,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.modalGrey.withOpacity(0.4),
//                                   borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     topLeft: Radius.circular(20),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 20, right: 20),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ButtonWidget(
//                                         backgroundColor: AppColors.mainColor,
//                                         text: "View",
//                                         textColor: Colors.white,
//                                       ),
//                                       SizedBox(height: 20),
//                                       ButtonWidget(
//                                         backgroundColor: AppColors.mainColor,
//                                         text: "Edit",
//                                         textColor: Colors.white,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                         return false;
//                       } else {
//                         return Future.delayed(Duration(seconds: 1),
//                             () => direction == DismissDirection.endToStart);
//                       }
//                     },
//                     key: ObjectKey(index),
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         left: 20,
//                         right: 20,
//                         bottom: 10,
//                       ),
//                       child: TaskWidget(
//                         text: _myData[index].name!,
//                         color: Colors.blueGrey,
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
