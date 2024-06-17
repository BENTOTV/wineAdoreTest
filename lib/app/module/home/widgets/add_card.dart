import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:test_flutter/app/core/utils/extention.dart';
import 'package:test_flutter/app/data/models/task.dart';
import 'package:test_flutter/app/module/home/controller.dart';
import 'package:test_flutter/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        child: InkWell(
          onTap: () async {
            await Get.defaultDialog(
                titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
                radius: 5,
                title: "Task Type",
                content: Form(
                    key: homeController.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                          child: TextFormField(
                            controller: homeController.editCtlr,
                            decoration: InputDecoration(
                              labelText: "Title",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter title";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                          child: Wrap(
                              spacing: 2.0.wp,
                              children: icons
                                  .map(
                                    (e) => Obx(() {
                                      final index = icons.indexOf(e);
                                      return ChoiceChip(
                                          selectedColor: Colors.grey[200],
                                          pressElevation: 0,
                                          backgroundColor: Colors.white,
                                          label: e,
                                          selected:
                                              homeController.chipIndex.value ==
                                                  index,
                                          onSelected: (bool selected) {
                                            homeController.chipIndex.value =
                                                selected ? index : 0;
                                          });
                                    }),
                                  )
                                  .toList()),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                minimumSize: Size(150, 40)),
                            onPressed: () {
                              if (homeController.formKey.currentState!
                                  .validate()) {
                                int icon = icons[homeController.chipIndex.value]
                                    .icon!
                                    .codePoint;
                                String Color =
                                    icons[homeController.chipIndex.value]
                                        .color!
                                        .toHex();
                                var task = Task(
                                  color: Color,
                                  title: homeController.editCtlr.text,
                                  icon: icon,
                                );
                                Get.back();
                                homeController.addTask(task)
                                    ? EasyLoading.showSuccess("Task Added")
                                    : EasyLoading.showError(
                                        "Failed to add task");
                              }
                            },
                            child: Text("Confrim"))
                      ],
                    )));
            homeController.editCtlr.clear();
            homeController.changeChipIndex(0);
          },
          child: DottedBorder(
            child: Center(
                child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            )),
          ),
        ));
  }
}
