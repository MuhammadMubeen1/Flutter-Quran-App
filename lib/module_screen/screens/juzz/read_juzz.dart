// // Import packages and libraries
// import 'dart:convert';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../core/app_color.dart';
// import '../../../screens/home_screen.dart';
// import '../../example/screens/home.dart';
// import '../../example/screens/reading_page.dart';
//
// import '../bookmark/bookmark.dart';
// import '../pagination_quran.dart';
// import '../quran_frame.dart';
// import '../settings.dart';
// import 'juz.dart';
//
// class ReadJuzz extends StatefulWidget {
//   ReadJuzz(this.curentIndex,this.curentSurah,this.verse,{Key? key}) : super(key: key);
//   var curentIndex;
//   var curentSurah;
//   var verse;
//
//
//   @override
//   State<ReadJuzz> createState() => _ReadJuzzState();
// }
//
// class _ReadJuzzState extends State< ReadJuzz> {
//   String selectedItem = '';
//
//   bool isLoading = true;
//   bool status = false;
//   final _pageNo = [
//     //SurahListWidget(),
//     HomeSceenSurah(),
//     const JuzScreen(),
//     //  PaginationQuranTraslation(),
//     HomeScreen(),
//     const BookMark(),
//
//     //QuranPageExample(),
//     SettingsScreen()
//   ];
//
//   List<dynamic> quranData = [];
//   List<dynamic> quranEnglish = [];
//   List<dynamic> quranUrdu = [];
//   List<dynamic> quranFrench = [];
//   List<dynamic> quranSpanish = [];
//   List<dynamic> quranRussian = [];
//   var chapter = [];
//   bool _showBottomNavBar = true;
//   void _handleScroll() {
//     if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
//       // Scrolling downward, hide the bottom navigation bar
//       if (_showBottomNavBar) {
//         setState(() {
//           _showBottomNavBar = false;
//         });
//       }
//     } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
//       // Scrolling upward, show the bottom navigation bar
//       if (!_showBottomNavBar) {
//         setState(() {
//           _showBottomNavBar = true;
//         });
//       }
//     }
//   }
//   ScrollController _scrollController = ScrollController();
//   @override
//   void initState() {
//     super.initState();
//     getQuranData();
//     getQuranTras();
//     _scrollController.addListener(_handleScroll);
//     // getQuranData();
//     print("index ${widget.curentIndex}");
//     selectedItem = 'Arabic';
//     getQuranTranslations();
//   }
//   String fullText = '';
//   List<String> pages = [];
//   var curentChapters;
//   var curentSurah;
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//   List<InlineSpan> _parseTextWithImages(String text) {
//     List<InlineSpan> spans = [];
//     RegExp numericRegExp = RegExp(r'\b\d+\b'); // Regular expression to match numeric values
//
//     var matches = numericRegExp.allMatches(text);
//
//     int previousEnd = 0;
//
//     for (var match in matches) {
//       spans.add(TextSpan(text: text.substring(previousEnd, match.start)));
//
//       int value = int.parse(match.group(0)!);
//
//       spans.add(WidgetSpan(
//         alignment: PlaceholderAlignment.middle,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Image.asset(
//               "assets/images/juzzimage.png",
//               width: 32, // Adjust the width as needed
//               height: 32, // Adjust the height as needed
//             ),
//             Text(
//               '$value',
//               style: const TextStyle(
//                 fontSize: 12, // Adjust the font size as needed
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//
//               ),
//             ),
//           ],
//         ),
//       ));
//
//       previousEnd = match.end;
//     }
//
//     if (previousEnd < text.length) {
//       spans.add(TextSpan(text: text.substring(previousEnd)));
//     }
//
//     return spans;
//   }
//   void getQuranData() async {
//     print("curent index ${widget.curentIndex}");
//     try {
//       var response = await http.get(Uri.parse('http://43.204.244.182/api/v1/juz/${widget.curentIndex}'));
//
//       if (response.statusCode == 200) {
//         var res = response.body;
//         var body = jsonDecode(res);
//         var quranData = body['data'];
//
//         setState(() {
//           isLoading = true;
//           chapter = quranData[0]['chapters'];
//         });
//
//         List<String> versesTextList = [];
//         String currentChapterName = ""; // Track the current chapter name
//
//         // Loop through each chapter
//         for (var chapterData in chapter) {
//           List verses = chapterData['verses'];
//           curentChapters = chapterData['chapter'];
//           curentSurah = chapterData['arabic_name'];
//           print("chapter ${curentChapters}");
//
//           // if (currentChapterName != curentSurah) {
//           //   // Add chapter name to the list only if it's different from the previous one
//           //   currentChapterName = curentSurah;
//           //   versesTextList.add("$currentChapterName");
//           // }
//
//           // Loop through each verse in the chapter and add verse text along with verse number
//           for (var verse in verses) {
//             var verseNumber = verse['verse'];
//             var text = verse['text'];
//             versesTextList.add("$text $verseNumber ");
//           }
//         }
//
//         // Combine all the verses' text into a single string.
//         fullText = versesTextList.join('');
//
//         // Now you have all the verses text combined into a single string.
//         print('Combined Verses Text: $fullText');
//
//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   // void getQuranData() async {
//   //   print("curent index ${widget.curentIndex}");
//   //   try {
//   //     var response = await http.get(Uri.parse('http://43.204.244.182/api/v1/juz/${widget.curentIndex}'));
//   //
//   //     if (response.statusCode == 200) {
//   //       var res = response.body;
//   //       var body = jsonDecode(res);
//   //       var quranData = body['data'];
//   //
//   //       setState(() {
//   //         isLoading = true;
//   //         chapter = quranData[0]['chapters'];
//   //       });
//   //
//   //       List<String> versesTextList = [];
//   //       String currentChapterName = ""; // Track the current chapter name
//   //       bool isFirstChapter = true; // Flag to track the first chapter
//   //
//   //       // Loop through each chapter
//   //       for (var chapterData in chapter) {
//   //         List verses = chapterData['verses'];
//   //         curentChapters = chapterData['chapter'];
//   //         curentSurah = chapterData['arabic_name'];
//   //         print("chapter ${curentChapters}");
//   //
//   //         if (!isFirstChapter && currentChapterName != curentSurah) {
//   //           // Add chapter name to the list only if it's different from the previous one
//   //           currentChapterName = curentSurah;
//   //           versesTextList.add("$currentChapterName");
//   //         }
//   //
//   //         // Loop through each verse in the chapter and add verse text
//   //         for (var verse in verses) {
//   //           var text = verse['text'];
//   //           versesTextList.add(text);
//   //         }
//   //
//   //         isFirstChapter = false; // Set the flag to false after the first chapter
//   //       }
//   //
//   //       // Combine all the verses' text into a single string.
//   //       fullText = versesTextList.join(' ');
//   //
//   //       // Now you have all the verses text combined into a single string.
//   //       print('Combined Verses Text: $fullText');
//   //       int charactersPerPage = 660;
//   //       while (fullText.isNotEmpty) {
//   //         if (pages.isEmpty) {
//   //           // First page, limit to 700 characters
//   //           if (fullText.length <= charactersPerPage) {
//   //             pages.add(fullText);
//   //             fullText = '';
//   //           } else {
//   //             String currentPage = fullText.substring(0, charactersPerPage);
//   //             pages.add(currentPage);
//   //             fullText = fullText.substring(charactersPerPage);
//   //           }
//   //         } else {
//   //           // Subsequent pages, limit to 1400 characters
//   //           charactersPerPage = 1200;
//   //           if (fullText.length <= charactersPerPage) {
//   //             pages.add(fullText);
//   //             fullText = '';
//   //           } else {
//   //             String currentPage = fullText.substring(0, charactersPerPage);
//   //             pages.add(currentPage);
//   //             fullText = fullText.substring(charactersPerPage);
//   //           }
//   //         }
//   //       }
//   //
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     } else {
//   //       print('Request failed with status: ${response.statusCode}');
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//
//   void getQuranTras() async {
//
//
//     try {
//       var response = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran?ChapterNo=${widget.curentIndex}'));
//
//       if (response.statusCode == 200) {
//         var res = response.body;
//         var body = jsonDecode(res);
//         quranData = body['data'];
//
//         setState(() {
//           quranData;
//         });
//
//
//
//         print("Here are the pages: $pages");
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   int currentStatus = 1;
//
//   void getQuranTranslations() async {
//     try {
//       // English Translation
//       var responseEnglish = await http.get(
//           Uri.parse('http://43.204.244.182/api/v1/quran?Language=english&${widget.curentIndex}'));
//       if (responseEnglish.statusCode == 200) {
//         var res = responseEnglish.body;
//         var body = jsonDecode(res);
//
//         setState(() {
//           quranEnglish = body['data'];
//         });
//
//       } else {
//         print('Request failed with status: ${responseEnglish.statusCode}');
//       }
//
//       // Urdu Translation
//       var responseUrdu = await http
//           .get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=urdu&${widget.curentIndex}'));
//       if (responseUrdu.statusCode == 200) {
//         var res = responseUrdu.body;
//         var body = jsonDecode(res);
//
//         setState(() {
//           quranUrdu = body['data'];
//         });
//       } else {
//         print('Request failed with status: ${responseUrdu.statusCode}');
//       }
//
//       // French Translation
//       var responseFrench = await http
//           .get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=french&${widget.curentIndex}'));
//       if (responseFrench.statusCode == 200) {
//         var res = responseFrench.body;
//         var body = jsonDecode(res);
//
//         setState(() {
//           quranFrench = body['data'];
//         });
//       } else {
//         print('Request failed with status: ${responseFrench.statusCode}');
//       }
//
//       // Spanish Translation
//       var responseSpanish = await http.get(
//           Uri.parse('http://43.204.244.182/api/v1/quran?Language=spanish&${widget.curentIndex}'));
//       if (responseSpanish.statusCode == 200) {
//         var res = responseSpanish.body;
//         var body = jsonDecode(res);
//
//         setState(() {
//           quranSpanish = body['data'];
//         });
//       } else {
//         print('Request failed with status: ${responseSpanish.statusCode}');
//       }
//
//       // Russian Translation
//       var responseRussian = await http.get(
//           Uri.parse('http://43.204.244.182/api/v1/quran?Language=russian&${widget.curentIndex}'));
//       if (responseRussian.statusCode == 200) {
//         var res = responseRussian.body;
//         var body = jsonDecode(res);
//
//         setState(() {
//           quranRussian = body['data'];
//         });
//       } else {
//         print('Request failed with status: ${responseRussian.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   void toggleLanguage(String language) {
//     setState(() {
//       selectedItem = language;
//     });
//   }
//   void showNestedPopupMenu(BuildContext context) {
//     final RenderBox button = context.findRenderObject() as RenderBox;
//     final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
//
//     showMenu<String>(
//       context: context,
//       position: RelativeRect.fromRect(
//         Rect.fromPoints(
//           button.localToGlobal(Offset.zero, ancestor: overlay),
//           button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
//         ),
//         Offset.zero & overlay.size,
//       ),
//       items: [
//         PopupMenuItem<String>(
//           value: 'Arabic',
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: selectedItem == 'Arabic'
//                       ? Color(0xffE4B452)
//                       : Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(height: 10),
//                       Text(
//                         "Arabic",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//         PopupMenuItem<String>(
//           value: 'English',
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: selectedItem == 'English'
//                       ? const Color(0xffE4B452)
//                       : Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(height: 10),
//                       Text(
//                         "English",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//         PopupMenuItem<String>(
//           value: 'Urdu',
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: selectedItem == 'urdu'
//                       ? Color(0xffE4B452)
//                       : Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(height: 10),
//                       Text(
//                         "Urdu",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//         PopupMenuItem<String>(
//           value: 'French',
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: selectedItem == 'French'
//                       ? Color(0xffE4B452)
//                       : Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(height: 10),
//                       Text(
//                         "French",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//         PopupMenuItem<String>(
//           value: 'Spanish',
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: selectedItem == 'Spanish'
//                       ? const Color(0xffE4B452)
//                       : Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(height: 10),
//                       Text(
//                         "Spanish",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//         PopupMenuItem<String>(
//           value: 'Russian',
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: selectedItem == 'Russian'
//                       ? Color(0xffE4B452)
//                       : Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       SizedBox(height: 10),
//                       const Text(
//                         "Russian",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ],
//
//       elevation: 8,
//     ).then((value) {
//       if (value != null) {
//         setState(() {
//           selectedItem = value;
//         });
//         //toggleLanguage;
//         print('Selected nested menu item: $value');
//       }
//     });
//   }
//
//   PageController pageController = PageController();
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return Scaffold(
//       bottomNavigationBar: _showBottomNavBar
//           ?  currentStatus ==1 || currentStatus ==0 || currentStatus ==3 || currentStatus ==4 ?Stack(
//         children: [
//           StyleProvider(
//             style: Style(),
//             child: ConvexAppBar(
//               backgroundColor: Colors.white,
//               // shadowColor: Colors.white,
//               initialActiveIndex: 1,
//               onTap: (int value) {
//                 setState(() {
//                   print("value ${value}");
//                   currentStatus = value;
//                 });
//               },
//               height: 64,
//               top: -27,
//               // curveSize: 120,
//
//               //curveSize:110,
//               style: TabStyle.fixed,
//               activeColor: iconColors,
//
//               color: defaultColor,
//               items: [
//                 TabItem(
//                     title: "Surah",
//                     icon: Padding(
//                       padding: const EdgeInsets.only(bottom: 4),
//                       child: Image.asset(
//                         'assets/images/Star-3.png',
//                         color: currentStatus == 0 ? iconColors : defaultColor,
//                       ),
//                     )),
//                 TabItem(
//                     title: "Juz",
//                     icon: Padding(
//                       padding: const EdgeInsets.only(bottom: 4),
//                       child: Image.asset(
//                         'assets/images/Star-3.png',
//                         color: currentStatus == 1 ? iconColors : defaultColor,
//                       ),
//                     )),
//                 TabItem(
//                     title: "Holy Quran",
//                     icon: Padding(
//                       padding: const EdgeInsets.only(bottom: 4),
//                       child: Image.asset(
//                         'assets/icons/Star.png',
//                         color: currentStatus == 2 ? iconColors : defaultColor,
//                       ),
//                     )),
//                 TabItem(
//                   title: "Bookmark",
//                   icon: Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Image.asset(
//                       'assets/images/Save instagram.png',
//                       //fit: BoxFit.cover,
//                       color: currentStatus == 3 ? iconColors : defaultColor,
//                     ),
//                   ),
//                 ),
//                 TabItem(
//                   title: "Settings",
//                   icon: Padding(
//                     padding: const EdgeInsets.only(bottom: 4),
//                     child: Image.asset(
//                       'assets/images/Settings.png',
//                       color: currentStatus == 4 ? iconColors : defaultColor,
//                     ),
//                   ),
//                 ),
//               ],
//               // backgroundColor: Colors.white,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 64.0),
//             child: Container(
//               width: double.infinity,
//               height: 20,
//               color: Colors.white,
//               // padding: const EdgeInsets.only(bottom: 30),
//             ),
//           ),
//         ],
//       ) : null
//           : null,
//         appBar:  currentStatus == 1?
//
//         AppBar(
//           backgroundColor: Colors.white,
//           elevation: 1,
//           // title: const Icon(
//           //   Icons.search,
//           //   size: 26.0,
//           //   color: Colors.black,
//           // ),
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//           ),
//           actions: <Widget>[
//
//             PopupMenuButton<String>(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                 // constraints: const BoxConstraints.tightFor(height: 300),
//                 // add icon, by default "3 dot" icon
//                 icon: const Icon(
//                   Icons.more_vert,
//                   color: Colors.black,
//                 ),
//                 onSelected:
//                     (v){
//                   if(v =="trans") {
//                     print("langiage");
//                     showNestedPopupMenu(context);
//
//
//
//                   }
//                 },
//                 itemBuilder: (context) {
//                   return [
//
//                     PopupMenuItem<String>(
//                       value: 'trans',
//                       child:
//                       Column(
//                         children: [
//                           Container(
//                             height: 50,
//                             //width: 200,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.white,
//                             ),
//
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   const Expanded(
//                                       child: Text(
//                                         "Select Language",
//                                         style: TextStyle(fontSize: 13),
//                                       )),
//                                   Text(
//                                     ' ${selectedItem}',
//                                     style: TextStyle(fontSize: 13),
//                                   ),
//                                   const Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     )
//                   ];
//                 })
//           ],
//         ) : null,
//
//         body: currentStatus ==1?
//
//
//         isLoading?Center(child: CircularProgressIndicator()):
//
//         selectedItem != 'Arabic'?   ListView.builder(
//           shrinkWrap: true,
//           itemCount: quranData.length,
//           physics: ScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(1.0),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(width: 30,),
//                         Expanded(
//                           child: Text(
//                             quranData[index]['text'].toString(),
//                             textAlign: TextAlign.center,
//                             //   textDirection: TextDirection.rtl,
//                             style: TextStyle(fontSize: 18.2,fontWeight: FontWeight.bold),
//                             //maxLines: 1,
//                           ),
//                         ),
//                         // SizedBox(width: 50,),
//
//                       ],
//                     ),
//                   ),
//                   selectedItem != 'Arabic'
//                       ? Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         Container(
//
//                           padding:
//                           EdgeInsets.symmetric(horizontal: 30),
//                           width: double.infinity,
//                           child: Text(
//                             _getTranslationText(index),
//                             textAlign: TextAlign.center,
//                             textDirection: TextDirection.rtl,
//                             style: TextStyle(
//                                 fontSize: 18.2,
//                                 fontWeight: FontWeight.w500),
//                             maxLines: 1,
//                           ),
//                         ),
//                         const Divider(
//                           height: 30,
//                           thickness: 3,
//                         ),
//                       ],
//                     ),
//                   )
//                       : Container(),
//                 ],
//               ),
//             );
//           },
//         ):
//         SingleChildScrollView(
//           controller:_scrollController ,
//         //  padding: EdgeInsets.all(16),
//           child:  Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.only(top: 0),
//                     height: 140,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage("assets/images/Group 3.png"),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 102),
//                       child: Center(
//                         child: Text(
//                           '${widget.curentSurah}',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Text.rich(
//                 textAlign: TextAlign.center,
//                 TextSpan(
//
//                   children: _parseTextWithImages( fullText,),
//                   style: TextStyle(
//
//                     fontSize: 35,
//                     height: 1.7,
//                     color: Colors.black.withOpacity(0.6),
//                   ),
//                   // textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//
//         )
//         // QuranFrame(
//         //
//         //   pages: pages,
//         //   specificPageIndex: 0,
//         //   chapter: curentChapters,
//         //   currentSurah: widget.curentSurah,
//         //   totalVerse: widget.verse,
//         //    )
//             : _pageNo[currentStatus],
//       //QuranPage(pages, ),
//
//     );
//   }
//
//   String _getTranslationText(int index) {
//     switch (selectedItem) {
//       case 'English':
//         return quranEnglish[index]['text'];
//       case 'Urdu':
//         return quranUrdu[index]['text'];
//       case 'French':
//         return quranFrench[index]['text'];
//       case 'Spanish':
//         return quranSpanish[index]['text'];
//       case 'Russian':
//         return quranRussian[index]['text'];
//       case 'Russian':
//         return quranRussian[index]['text'];
//       default:
//         return '';
//     }
//   }
//
// }
// class Style extends StyleHook {
//   @override
//   double get activeIconSize => 60;
//
//   @override
//   double get activeIconMargin => 0;
//
//   @override
//   double get iconSize => 30;
//
//   @override
//   TextStyle textStyle(Color color , String) {
//     return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w400);
//   }
//
// }