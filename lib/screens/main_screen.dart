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
        backgroundColor: floatingActionButtonColor,
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
            return Listener(
              onPointerMove: (event) {
                final pointerEvent = event;
                controller.scrollOffset.value =
                    pointerEvent.delta.dy; // Update scroll offset
                controller.showFilter.value = true;
              },
              onPointerCancel: (_) {
                controller.scrollOffset.value =
                    0; // Reset scroll offset if drag is canceled
              },
              child: SingleChildScrollView(
                child: controller.alDdata.isEmpty
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
                    : Column(
                        children: [
                          controller.showFilter.isTrue
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: Opacity(
                                    opacity: controller.opacity.value,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: controller.selectedFilter.value == 'All'?
                                                    Colors.black:floatingActionButtonColor),
                                            onPressed: () {
                                              controller.selectedFilter.value =
                                                  'All';
                                            },
                                            child: const Text(
                                              'All',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    controller.selectedFilter.value == 'Favourites'?
                                                    Colors.black:floatingActionButtonColor),
                                            onPressed: () {
                                              controller.selectedFilter.value =
                                                  'Favourites';
                                            },
                                            child: const Text(
                                              'Favourites',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(),
                          controller.selectedFilter.value == 'All'
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.alDdata.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    String cuttedDate =
                                        controller.alDdata[i]['date'].substring(
                                            0,
                                            controller
                                                    .alDdata[i]['date'].length -
                                                16);
                                    return myCard(controller,
                                        controller.alDdata, i, cuttedDate);
                                  })
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.favData.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    String cuttedDate =
                                        controller.favData[i]['date'].substring(
                                            0,
                                            controller
                                                    .favData[i]['date'].length -
                                                16);
                                    return myCard(controller,
                                        controller.favData, i, cuttedDate);
                                  }),
                        ],
                      ),
              ),
            );
          }),
    );
  }

  GestureDetector myCard(
      MainScreenController controller, List data, int i, String cuttedDate) {
    return GestureDetector(
      onTap: () {
        controller.isInScreen.value = false;
        Get.to(
          () => WordDetailsScreen(),
          arguments: Word(
            arWord: data[i]['arword'],
            enWord: data[i]['enword'],
            date: data[i]['date'],
            description: data[i]['description'],
            favorite: data[i]['favorite'],
            id: data[i]['id'],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              // 'tony botros is the best in the whole world',
                              data[i]['enword'],
                              style: GoogleFonts.mooli(
                                fontSize: 30,
                                // color:
                                //     Colors.grey[700],
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          data[i]['favorite'] == 1?
                         const Icon(
                            Icons.star,
                            size: 35,
                            color: Colors.yellow,
                          ): const SizedBox()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              cuttedDate,
                              style: GoogleFonts.mooli(
                                fontSize: 20,
                                color: Colors.blue.shade300,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              data[i]['arword'],
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
  }
}


  // controller.showFilter.isTrue
  //                             ? Container(
  //                               decoration: BoxDecoration(
  //                                 borderRadius:
  //                                     BorderRadius.circular(2),
  //                                 color: floatingActionButtonColor,
  //                               ),
  //                               child: TextButton(
  //                                 onPressed: () {},
  //                                 child: const Text('Words'),
  //                               ),
  //                             )
  //                             :