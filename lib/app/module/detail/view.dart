import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/module/detail/widgets/doing_list.dart';
import 'package:test_flutter/app/module/detail/widgets/done_list.dart';
import 'package:test_flutter/app/module/home/controller.dart';

class DetailPage extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value;
    var color = HexColor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.updateDetailTask();
                      homeController.setTask(null);
                      homeController.editCtlr.clear();
                    },
                    icon: Icon(Icons.arrow_back),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                  SizedBox(width: 3.0.wp),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                        color: color),
                  )
                ],
              ),
            ),
            Obx(() {
              var totalTask = homeController.doingTask.length +
                  homeController.doneTask.length;
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0.wp,
                  right: 16.0.wp,
                  top: 3.0.wp,
                ),
                child: Row(
                  children: [
                    Text("${totalTask} Tasks",
                        style:
                            TextStyle(fontSize: 12.0.sp, color: Colors.grey)),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: totalTask == 0 ? 1 : totalTask,
                      currentStep: homeController.doneTask.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color]),
                      unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!]),
                    ))
                  ],
                ),
              );
            }),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
              child: TextFormField(
                controller: homeController.editCtlr,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400]!,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            var success = homeController
                                .addDetailTask(homeController.editCtlr.text);
                            if (success) {
                              EasyLoading.showSuccess("Task Added");
                            } else {
                              EasyLoading.showError("Task Already Exist");
                            }
                            homeController.editCtlr.clear();
                          }
                        },
                        icon: Icon(Icons.done))),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your task Item";
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList()
          ],
        ),
      )),
    );
  }
}
