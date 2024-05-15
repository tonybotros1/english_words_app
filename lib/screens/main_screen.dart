import 'package:english_words_app/consts.dart';
import 'package:english_words_app/models/words.dart';
import 'package:english_words_app/screens/add_new_word_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/main_screen_controller.dart';
import 'word_details_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'All Words',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          Get.to(() => NewWordScreen(), transition: Transition.size);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: GetX<MainScreenController>(
          init: MainScreenController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: RefreshIndicator(
                  color: mainColor,
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    await controller.fetchData();
                  },
                  child: controller.data.isEmpty
                      ? SizedBox(
                          height: Get.height * 0.8,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/cat.png',
                                width: 200,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'No Cards Yet',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                        )
                      : ListView.builder(
                          itemCount: controller.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            Map wordsCard = controller.data[i];
                            String date = wordsCard['date'];
                            String cuttedDate =
                                date.substring(0, date.length - 16);
                            return GestureDetector(
                              onTap: () {
                                controller.isInScreen.value = false;
                                Get.to(
                                  () => WordDetailsScreen(),
                                  arguments: Word(
                                    arWord: wordsCard['arword'],
                                    enWord: wordsCard['enword'],
                                    date: wordsCard['date'],
                                    description: wordsCard['description'],
                                    favorite: wordsCard['favorite'],
                                    id: wordsCard['id'],
                                  ),
                                  transition: Transition.size,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: null,
                                    child: Card(
                                        elevation: 10,
                                        shadowColor: Colors.grey,
                                        // shadowColor: Colors.white,
                                        color: cardColor,
                                        surfaceTintColor: cardColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      // 'tony botros is the best in the whole world',
                                                      wordsCard['enword'],
                                                      style: GoogleFonts.mooli(
                                                        fontSize: 30,
                                                        // color:
                                                        //     Colors.grey[700],
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      cuttedDate,
                                                      style: GoogleFonts.mooli(
                                                        fontSize: 20,
                                                        color: Colors
                                                            .blue.shade300,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      wordsCard['arword'],
                                                      textAlign: TextAlign.end,
                                                      // 'طوني بطرس هو الأفضل في العالم كله',
                                                      style: GoogleFonts.mooli(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ))),
                              ),
                            );
                          })),
            );
          }),
    );
  }
}



// Padding(
//                                           padding: const EdgeInsets.all(20),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     FittedBox(
//                                                       child: Text(
//                                                         cuttedDate,
//                                                         style:
//                                                             GoogleFonts.mooli(
//                                                           fontSize: 20,
//                                                           color: mainColor,
//                                                           // fontWeight: FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   children: [
//                                                     FittedBox(
//                                                       child: Text(
//                                                         wordsCard['enword'],
//                                                         style:
//                                                             GoogleFonts.mooli(
//                                                           fontSize: 30,
//                                                           // color:
//                                                           //     Colors.grey[700],
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     FittedBox(
//                                                         child: Text(
//                                                       wordsCard['arword'],
//                                                       style: GoogleFonts.mooli(
//                                                         fontSize: 25,
//                                                         color: Colors.grey[600],
//                                                         // fontWeight: FontWeight.bold,
//                                                       ),
//                                                     ))
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),