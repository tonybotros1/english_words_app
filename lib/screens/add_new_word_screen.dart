import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../consts.dart';
import '../controllers/add_new_word_controller.dart';

class NewWordScreen extends StatelessWidget {
  NewWordScreen({super.key});

  final NewWordController newWordController = Get.put(NewWordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Word',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                GetBuilder<NewWordController>(
                  init: NewWordController(),
                  builder: (controller) {
                    return Form(
                      child: Column(
                        children: [
                          myTextFormField(
                            lableName: 'English word',
                            hintName: 'Enter english word',
                            controller: controller.enWord,
                            icon: const Icon(
                              Icons.language,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          myTextFormField(
                            lableName: 'Arabic word',
                            hintName: 'Enter arabic word',
                            controller: controller.arWord,
                            icon: const Icon(
                              Icons.translate,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          descriptiontBox(
                            lableName: 'Notes',
                            controller: controller.notes,
                            icon: const Icon(
                              Icons.notes,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  80), // Add spacing between the form fields and the button
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.addNewWord();
                                Get.back();
                              },
                              child: controller.loading == true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(color: mainColor),
                                    ),
                            ),
                          ),
                          const SizedBox(
                              height:
                                  20), // Add additional spacing at the bottom
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row myTextFormField({
    required String lableName,
    required String hintName,
    required TextEditingController controller,
    Icon? icon,
  }) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 50, 0, 20),
                child: icon)),
        Expanded(
          flex: 7,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 40, 20),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    floatingLabelStyle: TextStyle(
                      color: mainColor,
                    ),
                    labelText: lableName,
                    labelStyle: const TextStyle(color: Colors.grey),
                    alignLabelWithHint: true,
                    hintText: hintName,
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Row descriptiontBox({
  required TextEditingController controller,
  required String lableName,
  required Icon icon,
}) {
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 50, 0, 20), child: icon)),
      Expanded(
        flex: 7,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 40, 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700),
            ),
            height: 200,
            width: Get.width,
            child: TextFormField(
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  labelText: lableName,
                  floatingLabelStyle: TextStyle(
                    color: mainColor,
                  ),
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  hintText: 'Type your notes here...',
                  hintStyle: const TextStyle(color: Colors.grey)),
              onTap: () {
                controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.text.length,
                );
              },
              onChanged: (value) {
                controller.text = value;
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
              },
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
      ),
    ],
  );
}


// GetBuilder<NewWordController>(
//           init: NewWordController(),
//           builder: (controller) {
//             return Column(
//               children: [
//                 myTextFormField(
//                   lableName: 'English word',
//                   hintName: 'Enter english word',
//                   controller: controller.enWord,
//                   icon: const Icon(
//                     Icons.language,
//                     color: Colors.grey,
//                     size: 30,
//                   ),
//                 ),
//                 myTextFormField(
//                   lableName: 'Arabic word',
//                   hintName: 'Enter arabic word',
//                   controller: controller.arWord,
//                   icon: const Icon(
//                     Icons.translate,
//                     color: Colors.grey,
//                     size: 30,
//                   ),
//                 ),
//                 descriptiontBox(
//                     lableName: 'Notes', controller: controller.notes),
//                 const Expanded(flex: 7, child: SizedBox()),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Handle button press
//                     },
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(color: mainColor),
//                     ),
//                   ),
//                 ),
//                 const Expanded(flex: 2, child: SizedBox())
//               ],
//             );
//           }),