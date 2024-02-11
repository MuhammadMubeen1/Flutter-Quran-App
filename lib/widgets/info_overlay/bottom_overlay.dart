import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/index.dart';
import '../../providers/bookmark.dart';
import '../../providers/quran.dart';
import '../../providers/show_overlay_provider.dart';
import '../../providers/theme_provider.dart';
import '../../quran/page_data.dart';
import '../../screens/index_screen.dart';
import '../custom_button.dart';
import '../custom_container.dart';
import '../go_to_page_popup.dart';
import '../horizental_divider.dart';
import '../vertical_divider.dart';


class BottomOverlay extends StatefulWidget {
  const BottomOverlay({Key? key}) : super(key: key);

  @override
  State<BottomOverlay> createState() => _BottomOverlayState();
}

class _BottomOverlayState extends State<BottomOverlay> {
  bool isbookMark = false;
  @override
  Widget build(BuildContext context) {
    final quran = Provider.of<QuranProvider>(context, listen: false);
    final bookMark = Provider.of<BookMarkProvider>(context);
    final themeListenFalse = Provider.of<ThemeProvider>(context, listen: false);
    final overlay = Provider.of<ShowOverlayProvider>(context, listen: false);
   if(bookMark.bookMarkKeys.contains(quran.currentPage.toString()+quran.surahName)){
     setState(() {
       isbookMark = true;
     });
     
     
   }
   else{ 
     setState(() {
     isbookMark = false;
   });
     
   }
    void _goToBookMark() {
      quran.goToPage(bookMark.markPage);
      overlay.toggleisShowOverlay();
    }

    return CustomContainer(
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //    //   const Expanded(child: SearchButton()),
          //       const SizedBox(width: 10),
          //       CustomButton(
          //         onPressed: ()async{
          //           await bookMark.setBookMark(context);
          //         },
          //         text: bookMark.markButtonText,
          //
          //         onPrimary: Colors.black,
          //         //const Color(0xffA9A9A8),
          //         primary:
          //         bookMark.markButtonColor,
          //         svgIcon: AppAsset.saveFilled,
          //       )
          //     ],
          //   ),
          // ),
          // const HorizentalDiv(),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            GestureDetector(
              onTap: ()async{
                await bookMark.setBookMark(context);


                print("book mark is : ${bookMark.isMarkedPage}");
              },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child:
                  isbookMark?
                      
                   Icon(Icons.bookmark , size: 29, color: iconColors,): Icon(Icons.bookmark_outline , size: 29, color: iconColors,)
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              height: 35,
              width: 220,
              child: Center(child: Text("${ quran.surahName} , ${quran.currentPage}", style: TextStyle(fontSize: 15,),),),
            ),
            GestureDetector(
              onTap: (){

                showModalBottomSheet(
                  backgroundColor: Colors.grey.shade200,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Page',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 25,width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.shade300
                                      ),
                                      child: Center(
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Chapter"),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const IndexScreen(navigateFromQuranIndex: true,)));
                                            },
                                            child: Row(children: [

                                              Text(quran.surahName),
                                              SizedBox(width: 5,),
                                              Icon(Icons.arrow_forward_ios),

                                            ],),
                                          ),

                                        ],),



                                      SizedBox(height: 20,),
                                    ],),
                                  )
                              ),
                              SizedBox(height: 10),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      SizedBox(height: 10,),
                                     Text("Slide to select page"),
                                        SizedBox(height: 10,),
                                        Container(
                                          height: 40,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: quranPages.length, // Assuming quranPages is your list of pages
                                            itemBuilder: (context, index) {

                                              int pageIndex = index + 1; // Adding 1 to index to start from 1
                                              return GestureDetector(
                                                onTap: () {

                                                  print(pageIndex);
                                                  setState(() {
                                                    quran.goToPage(pageIndex - 1);
                                                  });

                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(28),
                                                  ),

                                                  elevation: quran.currentPage==pageIndex? 5:0,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 60, // Set a reasonable width for the index display
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                      pageIndex.toString(),
                                                      style: TextStyle(fontSize: 18,
                                                        color: Colors.black
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),




                                      SizedBox(height: 10,),
                                    ],),
                                  )
                              ),
                              SizedBox(height: 15,),


                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.more_vert,  color: iconColors, size: 29,),
                ))
          ],),


          // SizedBox(
          //   height: 45,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 5,
          //         child: TextButton.icon(
          //           onPressed: _goToBookMark,
          //           icon: SvgPicture.asset(AppAsset.saveFilled,color: Colors.black,),
          //           label: const FittedBox(
          //             child: Text(
          //               AppConstant.goToBookMark,
          //               style: textStyle,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const VerticalDiv(),
          //       Expanded(
          //         flex: 4,
          //         child: TextButton.icon(
          //           onPressed: () {
          //             showDialog(
          //               barrierDismissible: true,
          //               context: context,
          //               builder: (context) => const GoToPagePopup(),
          //             );
          //             overlay.toggleisShowOverlay();
          //           },
          //           icon: SvgPicture.asset(AppAsset.page,color: Colors.black,),
          //           label: const FittedBox(
          //             child: Text(
          //               AppConstant.changePage,
          //               style: textStyle,
          //             ),
          //           ),
          //         ),
          //       ),
          //      // const VerticalDiv(),
          //       // IconButton(
          //       //   icon: Consumer<ThemeProvider>(
          //       //     builder: (context, theme, child) {
          //       //       return SvgPicture.asset(
          //       //           theme.isDarkMode ? AppAsset.sun : AppAsset.moon);
          //       //     },
          //       //   ),
          //       //   onPressed: () {
          //       //     themeListenFalse.toggleTheme(!themeListenFalse.isDarkMode);
          //       //   },
          //       // ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 20,),
          //const HorizentalDiv(),
          // SizedBox(
          //   height: 45,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextButton.icon(
          //
          //           onPressed: () {
          //             Navigator.push(context, MaterialPageRoute(builder: (context)=>const IndexScreen(navigateFromQuranIndex: true,)));
          //            // Navigator.of(context).pushNamed('/index');
          //           },
          //           icon: SvgPicture.asset(AppAsset.index),
          //           label: const Text(
          //             AppConstant.index,
          //             style: textStyle,
          //           ),
          //         ),
          //       ),
          //       const VerticalDiv(),
          //       Expanded(
          //         child: TextButton.icon(
          //           onPressed: () {
          //             Navigator.of(context).pushNamed('/juz-index');
          //           },
          //           icon: SvgPicture.asset(AppAsset.part),
          //           label: const Text(
          //             AppConstant.ajzaa,
          //             style: textStyle,
          //           ),
          //         ),
          //       ),
          //       const VerticalDiv(),
          //       Expanded(
          //         child: TextButton.icon(
          //           onPressed: () {
          //             Navigator.of(context).pushNamed('/douaa');
          //           },
          //           icon: SvgPicture.asset(AppAsset.hand),
          //           label: const FittedBox(
          //             child: FittedBox(
          //               child: Text(
          //                 AppConstant.douaa,
          //                 style: textStyle,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

const textStyle = TextStyle(
  color: Colors.black,
  fontSize: 15,
);
