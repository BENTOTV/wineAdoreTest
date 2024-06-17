import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/data/models/task.dart';
import 'package:test_flutter/app/module/detail/view.dart';
import 'package:test_flutter/app/module/home/controller.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final colors = HexColor.fromHex(task.color);
    final squarewidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homeController.setTask(task);
        homeController.changeTask(task.tasks ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squarewidth / 2,
        height: squarewidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps:
                  homeController.isTaskEmpty(task) ? 1 : task.tasks!.length,
              currentStep: homeController.isTaskEmpty(task)
                  ? 0
                  : homeController.getDoneTask(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colors.withOpacity(0.5), colors]),
              unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                  color: colors),
            ),
            SizedBox(height: 4.0.wp),
            Padding(
              padding: EdgeInsets.all(2.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.wp),
                  Text(
                    "${task.tasks?.length ?? 0} Tasks",
                    style: TextStyle(fontSize: 10.0.sp, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
