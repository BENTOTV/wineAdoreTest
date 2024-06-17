import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/module/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.editCtlr.clear();
                        homeController.setTask(null);
                      },
                      icon: Icon(Icons.close),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            if (homeController.task.value == null) {
                              EasyLoading.showError("Please select Task Type");
                              return;
                            } else {
                              var success = homeController.updateTask(
                                  homeController.task.value!,
                                  homeController.editCtlr.text);
                              if (success) {
                                Get.back();
                                EasyLoading.showSuccess("Task Item Added");
                                homeController.setTask(null);
                              } else {
                                EasyLoading.showError("Task already exists");
                              }
                              homeController.editCtlr.clear();
                            }
                          }
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 14.0.sp,
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  "New Task",
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeController.editCtlr,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter Task Item";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  "Add to",
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeController.tasks.map(
                (e) => Obx(
                  () => InkWell(
                    onTap: () => homeController.setTask(e),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.wp, vertical: 3.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                    IconData(e.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(e.color)),
                                SizedBox(width: 3.0.wp),
                                Text(e.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            if (homeController.task.value == e)
                              Icon(Icons.check, color: Colors.blue),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
