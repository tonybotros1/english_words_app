import 'package:english_words_app/controllers/word_details_controller.dart';
import 'package:english_words_app/models/words.dart';
import 'package:english_words_app/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts.dart';
import 'edit_word_screen.dart';

class WordDetailsScreen extends StatelessWidget {
  WordDetailsScreen({super.key});

  final WordDetailsController wordDetailsController =
      Get.put(WordDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: const Text('Alert'),
                            content: const Text(
                                'Are you sure you want to delete this card?'),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              CupertinoDialogAction(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: mainColor),
                                ),
                                onPressed: () {
                                  wordDetailsController
                                      .deleteData(wordDetailsController.id);
                                  Get.offAll(() => MainScreen());
                                },
                              )
                            ],
                          ));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
            TextButton(
                onPressed: () {
                  Get.to(() => const EditWordScreen(),
                      arguments: Word(
                        arWord: wordDetailsController.arword,
                        date: wordDetailsController.date,
                        description: wordDetailsController.description,
                        enWord: wordDetailsController.enword,
                        favorite: wordDetailsController.favorite,
                        id: wordDetailsController.id,
                      ),
                      transition: Transition.size);
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.white),
                ))
          ],
          title: const Text(
            'Infos',
            style: TextStyle(color: Colors.white),
          ),
          // centerTitle: true,
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<WordDetailsController>(
            init: WordDetailsController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'English',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    controller.addToFavorite();
                                  },
                                  icon: controller.favorite == 1
                                      ? const Icon(
                                          Icons.star,
                                          size: 35,
                                          color: Colors.yellow,
                                        )
                                      : const Icon(
                                          Icons.star,
                                          size: 35,
                                          color: Colors.white,
                                        ))
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  textAlign: TextAlign.start,
                                  '${controller.enword}',
                                  // 'tony botrods infm fmf,f, f, fkd,dm',
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.isPlaying = true;
                                    controller.speakEN('${controller.enword}');
                                  },
                                  icon: Icon(
                                    controller.isPlaying == false
                                        ? Icons.volume_up
                                        : Icons.stop,
                                    size: 30,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Divider(
                            thickness: 1.5,
                            color: Colors.blue.shade700,
                            indent: 80,
                            endIndent: 80,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Arabic',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade300),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.isPlaying = true;

                                    controller.speakAR('${controller.arword}');
                                  },
                                  icon: Icon(
                                    Icons.volume_up,
                                    size: 30,
                                    color: Colors.blue.shade300,
                                  )),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    '${controller.arword}',
                                    // 'أقول وقد ناحت بقربي',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.blue.shade300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: mainColor,
                            border: Border.all(color: mainColor),
                            borderRadius: BorderRadius.circular(10)),
                        width: Get.width,
                        height: null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue.shade300,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            controller.description != null
                                ? Text(
                                    '${controller.description}',
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : const Text(
                                    'No Description added',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
