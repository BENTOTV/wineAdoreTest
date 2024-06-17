import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/module/home/controller.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() {
      var createdTask = homeController.getTotalTask();
      var completedTask = homeController.getTotalDoneTask();
      var liveTask = createdTask - completedTask;
      var percent = (completedTask / createdTask * 100).toStringAsFixed(0);
      return ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              "My Report",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            child: Text(DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 4.0.wp),
            child: Divider(
              thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatus(Colors.green, liveTask, "Live Task"),
                _buildStatus(Colors.orange, completedTask, "Completed Task"),
                _buildStatus(Colors.blue, createdTask, "Created Task"),
              ],
            ),
          ),
          SizedBox(height: 8.0.wp),
          UnconstrainedBox(
              child: SizedBox(
            width: 70.0.wp,
            height: 70.0.wp,
            child: CircularStepProgressIndicator(
              totalSteps: createdTask == 0 ? 1 : createdTask,
              currentStep: completedTask,
              stepSize: 20,
              padding: 0,
              selectedColor: Colors.green,
              unselectedColor: Colors.grey[200]!,
              width: 150,
              selectedStepSize: 22,
              roundedCap: (_, __) => true,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${createdTask == 0 ? 1 : percent}%",
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.0.wp),
                    Text(
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    )
                  ]),
            ),
          ))
        ],
      );
    })));
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 0.5.wp),
          ),
        ),
        SizedBox(width: 3.0.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${number}',
                style:
                    TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold)),
            Text(text, style: TextStyle(fontSize: 12.0.sp, color: Colors.grey)),
          ],
        )
      ],
    );
  }
}
