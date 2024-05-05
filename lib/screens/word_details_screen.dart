import 'package:english_words_app/controllers/word_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts.dart';

class WordDetailsScreen extends StatelessWidget {
  const WordDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Infos',
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
                          Text(
                            'English',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${controller.enword}',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.grey[700]),
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
                                    color: mainColor,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Divider(
                            color: mainColor,
                            indent: 80,
                            endIndent: 80,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Arabic',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff7AB2B2)),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.speakAR('${controller.arword}');
                                  },
                                  icon: Icon(
                                    Icons.volume_up,
                                    size: 30,
                                    color: mainColor,
                                  )),
                              Text(
                                '${controller.arword}',
                                style: const TextStyle(
                                    fontSize: 30, color: Color(0xff7AB2B2)),
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
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            controller.description != null
                                ? Text('${controller.description}')
                                : Text(
                                    'No Description added',
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 15),
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
