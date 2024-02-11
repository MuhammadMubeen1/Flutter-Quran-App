import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:untitled/consolePrintWithColor.dart';

import '../../../core/app_color.dart';
import '../../../providers/bookmark.dart';
import '../../../providers/bottom_navigation_provider.dart';
import '../../../providers/quran.dart';
import '../../../screens/home_screen.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  List<Map<String, dynamic>> _journals = [];
  List<String> pages = [];
  // var quran= [];
  String fullText = '';

  bool   isLoadPage = true;


  bool _isLoading = true;

  getBookMarks()async{
    final quran = Provider.of<QuranProvider>(context, listen: false);
    await Provider.of<BookMarkProvider>(context,listen: false).getBookMarks(context);
    setState(() {
      _isLoading=false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100),(){
      getBookMarks();
    });

    // TODO: implement initState
    super.initState();
    //_refreshJournals();
   // fetchQuranData();
  }
  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<BottomNavigationProvider>(context, listen: false);
    var bookMark=Provider.of<BookMarkProvider>(context,listen: false);
    final quran = Provider.of<QuranProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Bookmarks",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          // Icon(
          //   Icons.search,
          //   color: defaultColor,
          //   size: 28,
          // ),
          // Icon(
          //   Icons.more_vert,
          //   color: defaultColor,
          //   size: 28,
          // ),
          SizedBox(
            width: 5,
          ),
        ],
      ),

      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Holy Quran",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    " القرآن الكريم",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              bookMark.bookMarks.isEmpty? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: iconColors.withOpacity(0.7),
                ),
                child:  Column(
                  children: [
                    SizedBox(height: 15,),
                    Center(child: Text("You don't have any bookmarks yet")),
                    SizedBox(height: 15,),
                  ],
                ),
              ):
              Container(),
              const SizedBox(
                height: 15,
              ),
              _isLoading?const Center(child: CircularProgressIndicator()):
              ListView.builder(
                physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:bookMark.bookMarks.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: ()async{

                        if(bookMark.bookMarks[index].surahName.contains("ا")){
                          bookMark.updateSelectedItem("Arabic");
                          await indexProvider.updateIndex(2);
                          Future.delayed(const Duration(milliseconds: 300),(){
                            quran.goToPage(bookMark.bookMarks[index].pageNumber - 1);
                            print("going");
                          });

                          // Future.delayed(const Duration(milliseconds: 400),(){
                          //   quran.goToPage(bookMark.bookMarks[index].pageNumber - 1);
                          //   print("going");
                          // });
                        }else {
                          bookMark.updateScrollIndex(bookMark.bookMarks[index].pageNumber);
                          printLog("========>${bookMark.bookMarks[index].pageNumber}");
                          bookMark.updateSelectedItem(bookMark.bookMarks[index].surahName);
                          await indexProvider.updateIndex(2);
                        }

                        // if(bookMark.bookMarks[index].surahName =="Quran"){
                        //
                        // } else{
                        //   await indexProvider.updateIndex(2);
                        //   print("status ${bookMark.bookMarks[index].status}" );
                        //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(language: bookMark.bookMarks[index].surahName,)));
                        //
                        // }
                       //

                     },
                      child: Container(
                        margin: EdgeInsets.symmetric( vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                        child:  Column(
                          children:  [
                            ListTile(
                              title: Text(
                        bookMark.bookMarks[index].surahName,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                              subtitle: Text('Page ${bookMark.bookMarks[index].pageNumber}'),
                              trailing: IconButton(
                                onPressed: ()async{
                                  await bookMark.deleteBookMark(context, bookMark.bookMarks[index]);
                                  await getBookMarks();
                                },
                                icon: Icon(Icons.delete_forever,size: 30,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

              const SizedBox(
                height: 35,
              ),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:  [
              //     Text(
              //       "Juz 1",
              //       style: TextStyle(color: Colors.black, fontSize: 14),
              //     ),
              //     Text(
              //       "جزء او أجزاء",
              //       style: TextStyle(color: Colors.black, fontSize: 17),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
              //   child:  Column(
              //     children:  [
              //       ListTile(
              //         title: Text(
              //           'Alif Laam Meem',
              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
              //         ),
              //         subtitle: Text('Page 522'),
              //         trailing: Text(
              //           'تلك الرسل',
              //           style: TextStyle(color: Colors.black, fontSize: 15),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 35,
              // ),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:   [
              //     Text(
              //       "Surah",
              //       style: TextStyle(color: Colors.black, fontSize: 14),
              //     ),
              //     Text(
              //       "سورة او سور",
              //       style: TextStyle(color: Colors.black, fontSize: 17),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
              //   child:  Column(
              //     children:  [
              //       ListTile(
              //         title: Text(
              //           'Alif Laam Meem',
              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
              //         ),
              //         subtitle: Text('Page 522'),
              //         trailing: Text(
              //           'تلك الرسل',
              //           style: TextStyle(color: Colors.black, fontSize: 15),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
