import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/module/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doingTask.isEmpty &&
            homeController.doneTask.isEmpty
        ? Column(
            children: [
              Image.asset(
                "assest/image/activities_not_found.png",
                width: 65.0.wp,
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  "No Task Available",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              ...homeController.doingTask
                  .map((Element) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0.wp, vertical: 3.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: Element['done'],
                                onChanged: (value) {
                                  homeController.donetodo(Element['title']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                Element['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              if (homeController.doneTask.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
            ],
          ));
  }
}
