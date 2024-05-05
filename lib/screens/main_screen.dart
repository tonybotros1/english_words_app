import 'package:english_words_app/consts.dart';
import 'package:english_words_app/models/words.dart';
import 'package:english_words_app/screens/add_new_word_screen.dart';
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
      backgroundColor: Colors.white,
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
                child: controller.data.isNotEmpty
                    ? SizedBox(
                        height: Get.height * 0.8,
                        child: ListView.builder(
                            itemCount: controller.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              Map wordsCard = controller.data[i];
                              String date = wordsCard['date'];
                              String cuttedDate =
                                  date.substring(0, date.length - 16);
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const WordDetailsScreen(),
                                    arguments: Word(
                                      arWord: wordsCard['arword'],
                                      enWord: wordsCard['enword'],
                                      date: wordsCard['date'],
                                      description: wordsCard['description'],
                                      favorite: wordsCard['favorite'],
                                      id: wordsCard['id'],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                    height: 200,
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      surfaceTintColor: cardColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      cuttedDate,
                                                      style: GoogleFonts.mooli(
                                                        fontSize: 20,
                                                        color: mainColor,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      wordsCard['enword'],
                                                      style: GoogleFonts.mooli(
                                                        fontSize: 30,
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  FittedBox(
                                                      child: Text(
                                                    wordsCard['arword'],
                                                    style: GoogleFonts.mooli(
                                                      fontSize: 25,
                                                      color: Colors.grey[600],
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      )
                    : SizedBox(
                        height: Get.height * 0.8,
                        child: const Center(
                          child: Text(
                            'No words yet',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
              ),
            );
          }),
    );
  }
}



//  Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         shadowColor: Colors.grey[300],
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               FittedBox(
//                                 child: Text(
//                                   '${wordsCard['enword']}',
//                                   style: GoogleFonts.mooli(
//                                     fontSize: 30,
//                                     color: Colors.grey[800],
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     FittedBox(
//                                       child: Text(
//                                         cuttedDate,
//                                         style: GoogleFonts.mooli(
//                                           fontSize: 15,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                     // const Expanded(child: SizedBox()),
//                                     FittedBox(
//                                       child: Text(
//                                         'مbbbbvvvvvvvvvvvvvvvvvvvvvsbbbbbbbbbbbbbbbbbbرحباً',
//                                         style: GoogleFonts.mooli(
//                                           fontSize: 25,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),