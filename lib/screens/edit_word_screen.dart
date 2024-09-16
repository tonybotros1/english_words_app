import 'package:english_words_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts.dart';
import '../controllers/edit_word_controller.dart';

class EditWordScreen extends StatelessWidget {
  const EditWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Edit Infos',
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
                GetBuilder<EditWordController>(
                  init: EditWordController(),
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
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          myTextFormField(
                            lableName: 'Arabic word',
                            hintName: 'Enter arabic word',
                            controller: controller.arWord,
                            icon: const Icon(
                              Icons.translate,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          descriptiontBox(
                            lableName: 'Notes',
                            controller: controller.notes,
                            icon: const Icon(
                              Icons.notes,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  80), // Add spacing between the form fields and the button
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          mainColor)),
                              onPressed: () async {
                                await controller.editCard(controller.id);
                                Get.offAll(() => MainScreen());
                              },
                              child: controller.loading == true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
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
              padding: const EdgeInsets.fromLTRB(25, 50, 0, 20), child: icon)),
      Expanded(
        flex: 7,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 40, 20),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)),
                  floatingLabelStyle: TextStyle(
                    color: Colors.blue.shade300,
                  ),
                  labelText: lableName,
                  labelStyle: const TextStyle(color: Colors.white),
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
              border: Border.all(color: Colors.white),
            ),
            height: 200,
            width: Get.width,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: lableName,
                  floatingLabelStyle: TextStyle(
                    color: Colors.blue.shade300,
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
