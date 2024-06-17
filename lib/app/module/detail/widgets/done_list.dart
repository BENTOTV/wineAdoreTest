import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/core/values/colors.dart';
import 'package:test_flutter/app/module/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doneTask.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: Text("Completed ${homeController.doneTask.length} Task",
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.grey)),
              ),
              ...homeController.doneTask.map((element) => Dismissible(
                    key: ObjectKey(element),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        homeController.deleteDoneTodo(element),
                    background: Container(
                      color: Colors.red.withOpacity(0.8),
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0.wp),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp, horizontal: 9.0.wp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.done,
                              color: blue,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Text(element['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough)),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )
        : Container());
  }
}
