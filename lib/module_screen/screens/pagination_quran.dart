// // Import packages and libraries
// import 'dart:convert';
//
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
// import 'package:untitled/screens/settings.dart';
//
// import '../example/screens/home.dart';
// import '../res/colors.dart';
// import 'bookmark/bookmark.dart';
// import 'juzz/juz.dart';
//
// class PaginationQuran extends StatefulWidget {
//   const PaginationQuran({Key? key}) : super(key: key);
//
//   @override
//   State<PaginationQuran> createState() => _PaginationQuranState();
// }
//
// class _PaginationQuranState extends State<PaginationQuran> {
//   String selectedItem = '';
//
//   bool isLoading = true;
//   bool status = false;
//   var quran = [];
//   List<dynamic> quranData = [];
//   List<dynamic> quranEnglish = [];
//   List<dynamic> quranUrdu = [];
//   List<dynamic> quranFrench = [];
//   List<dynamic> quranSpanish = [];
//   List<dynamic> quranRussian = [];
//
//   int? spaceCount;
//   final _pageNo = [
//     //SurahListWidget(),
//     HomeSceenSurah(),
//     const JuzScreen(),
//     //  PaginationQuranTraslation(),
//     PaginationQuran(),
//     const BookMark(),
//
//     //QuranPageExample(),
//     SettingsScreen()
//   ];
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_handleScroll);
//     quranLine();
//
//     getQuranTras();
//     selectedItem = 'Arabic';
//     getQuranTranslations();
//   }
//
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
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   String fullText = '';
//   List<String> pages = [];
//
//   int currentStatus = 2;
//
//   ScrollController _scrollController = ScrollController();
//   bool _showBottomNavBar = true;
//
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
//                   color: selectedItem == 'Arabic' ? Color(0xffE4B452) : Colors.transparent,
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
//                   color: selectedItem == 'English' ? const Color(0xffE4B452) : Colors.transparent,
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
//                   color: selectedItem == 'urdu' ? Color(0xffE4B452) : Colors.transparent,
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
//                   color: selectedItem == 'French' ? Color(0xffE4B452) : Colors.transparent,
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
//                   color: selectedItem == 'Spanish' ? const Color(0xffE4B452) : Colors.transparent,
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
//                   color: selectedItem == 'Russian' ? Color(0xffE4B452) : Colors.transparent,
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
//   List<Map<String, dynamic>> combinedVerses = [];
//   quranLine() async {
//     var request = http.Request('GET', Uri.parse('http://43.204.244.182/api/v1/quran'));
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var res = await response.stream.bytesToString();
//       var body = jsonDecode(res);
//
//       // Combine verses for each chapter
//       String? currentChapter;
//       List<String> chapterVerses = [];
//
//       for (var verse in body["data"]) {
//         if (currentChapter == null) {
//           // Initialize the currentChapter with the first chapter value
//           currentChapter = verse['chapter'];
//         }
//
//         if (verse['chapter'] != currentChapter) {
//           combinedVerses.add({
//             'chapter': currentChapter,
//             'verses': chapterVerses.join(' '), // Combine the verses into a single string
//           });
//
//           currentChapter = verse['chapter'];
//           chapterVerses = [];
//         }
//         chapterVerses.add('${verse['text']} ${verse['verse']}');
//       }
//
//       // Add the last chapter after the loop ends
//       if (chapterVerses.isNotEmpty) {
//         combinedVerses.add({
//           'chapter': currentChapter,
//           'verses': chapterVerses.join(' '), // Combine the verses into a single string
//         });
//       }
//
//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
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
//   void getQuranTras() async {
//     try {
//       var response = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran'));
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
//
//   void getQuranTranslations() async {
//     try {
//       // English Translation
//       var responseEnglish = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=english'));
//       if (responseEnglish.statusCode == 200) {
//         var res = responseEnglish.body;
//         var body = jsonDecode(res);
//
//         setState(() {
//           quranEnglish = body['data'];
//         });
//       } else {
//         print('Request failed with status: ${responseEnglish.statusCode}');
//       }
//
//       // Urdu Translation
//       var responseUrdu = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=urdu'));
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
//       var responseFrench = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=french'));
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
//       var responseSpanish = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=spanish'));
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
//       var responseRussian = await http.get(Uri.parse('http://43.204.244.182/api/v1/quran?Language=russian'));
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
//
//   bool isSearching = false;
//
//   TextEditingController search = TextEditingController();
//
//   PageController pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: _showBottomNavBar
//             ? Stack(
//                 children: [
//                   StyleProvider(
//                     style: Style(),
//                     child: ConvexAppBar(
//                       backgroundColor: Colors.white,
//                       // shadowColor: Colors.white,
//                       initialActiveIndex: 2,
//                       onTap: (int value) {
//                         setState(() {
//                           print("value ${value}");
//                           currentStatus = value;
//                         });
//                       },
//                       height: 64,
//                       top: -27,
//                       // curveSize: 120,
//
//                       //curveSize:110,
//                       style: TabStyle.fixed,
//                       activeColor: iconColors,
//
//                       color: defaultColor,
//                       items: [
//                         TabItem(
//                             title: "Surahs",
//                             icon: Padding(
//                               padding: const EdgeInsets.only(bottom: 4),
//                               child: Image.asset(
//                                 'assets/images/Star-3.png',
//                                 color: currentStatus == 0 ? iconColors : defaultColor,
//                               ),
//                             )),
//                         TabItem(
//                             title: "Juz",
//                             icon: Padding(
//                               padding: const EdgeInsets.only(bottom: 4),
//                               child: Image.asset(
//                                 'assets/images/Star-3.png',
//                                 color: currentStatus == 1 ? iconColors : defaultColor,
//                               ),
//                             )),
//                         TabItem(
//                             title: "Holy Quran",
//                             icon: Padding(
//                               padding: const EdgeInsets.only(bottom: 4),
//                               child: Image.asset(
//                                 'assets/icons/Star.png',
//                                 color: currentStatus == 2 ? iconColors : defaultColor,
//                               ),
//                             )),
//                         TabItem(
//                           title: "Bookmark",
//                           icon: Padding(
//                             padding: const EdgeInsets.only(bottom: 4),
//                             child: Image.asset(
//                               'assets/images/Save instagram.png',
//                               //fit: BoxFit.cover,
//                               color: currentStatus == 3 ? iconColors : defaultColor,
//                             ),
//                           ),
//                         ),
//                         TabItem(
//                           title: "Settings",
//                           icon: Padding(
//                             padding: const EdgeInsets.only(bottom: 4),
//                             child: Image.asset(
//                               'assets/images/Settings.png',
//                               color: currentStatus == 4 ? iconColors : defaultColor,
//                             ),
//                           ),
//                         ),
//                       ],
//                       // backgroundColor: Colors.white,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 64.0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 20,
//                       color: Colors.white,
//                       // padding: const EdgeInsets.only(bottom: 30),
//                     ),
//                   ),
//                 ],
//               )
//             : null,
//         appBar: currentStatus == 2
//             ? AppBar(
//                 backgroundColor: Colors.white,
//                 elevation: 1,
//                 centerTitle: true,
//                 title: isSearching
//                     ? TextFormField(
//                         autocorrect: false,
//                         enableSuggestions: false,
//                         autofocus: true,
//                         controller: search,
//                         onChanged: (val) {
//                           setState(() {});
//                         },
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Search Surah',
//                           focusedBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                       )
//                     : const Text(
//                         "Quran",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                 actions: <Widget>[
//                   // selectedItem == 'Arabic'
//                   //     ? GestureDetector(
//                   //         onTap: () {
//                   //           setState(() {
//                   //             isSearching = !isSearching;
//                   //           });
//                   //         },
//                   //         child: const Icon(
//                   //           Icons.search,
//                   //           color: defaultColor,
//                   //           size: 28,
//                   //         ),
//                   //       )
//                   //     : Container(),
//                   PopupMenuButton<String>(
//                       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                       // constraints: const BoxConstraints.tightFor(height: 300),
//                       // add icon, by default "3 dot" icon
//                       icon: const Icon(
//                         Icons.more_vert,
//                         color: Colors.black,
//                       ),
//                       onSelected: (v) {
//                         if (v == "trans") {
//                           print("langiage");
//                           showNestedPopupMenu(context);
//                         }
//                       },
//                       itemBuilder: (context) {
//                         return [
//                           PopupMenuItem<String>(
//                             value: 'trans',
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   //width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Colors.white,
//                                   ),
//
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         const Expanded(
//                                             child: Text(
//                                           "Select Language",
//                                           style: TextStyle(fontSize: 13),
//                                         )),
//                                         Text(
//                                           ' ${selectedItem}',
//                                           style: TextStyle(fontSize: 13),
//                                         ),
//                                         const Icon(
//                                           Icons.arrow_forward_ios,
//                                           color: Colors.grey,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           )
//                         ];
//                       })
//                 ],
//               )
//             : null,
//         body: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : NotificationListener<ScrollNotification>(
//                 onNotification: (scrollNotification) {
//                   if (scrollNotification is ScrollUpdateNotification) {
//                     _handleScroll();
//                   }
//                   return false;
//                 },
//                 child: currentStatus == 2
//                     ? selectedItem != 'Arabic'
//                         ? ListView.builder(
//                             controller: _scrollController,
//                             shrinkWrap: true,
//                             physics: ScrollPhysics(),
//                             itemCount: quranData.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(0),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 20),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               quranData[index]['text'].toString(),
//                                               textAlign: TextAlign.center,
//
//                                               style: const TextStyle(fontSize: 16.2, fontWeight: FontWeight.bold),
//                                               //maxLines: 1,
//                                             ),
//                                           ),
//                                           // SizedBox(width: 50,),
//                                         ],
//                                       ),
//                                     ),
//                                     selectedItem != 'Arabic'
//                                         ? Padding(
//                                             padding: const EdgeInsets.only(top: 10),
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                                                   width: double.infinity,
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.only(left: 5),
//                                                     child: Text(
//                                                       _getTranslationText(index),
//                                                       textAlign: TextAlign.center,
//                                                       textDirection: TextDirection.rtl,
//                                                       style:
//                                                           const TextStyle(fontSize: 18.2, fontWeight: FontWeight.w500),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const Divider(
//                                                   height: 30,
//                                                   thickness: 3,
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         : Container(),
//                                   ],
//                                 ),
//                               );
//                             },
//                           )
//                         :
//                 ListView.builder(
//                   controller: _scrollController,
//                   itemCount: combinedVerses.length,
//                   itemBuilder: (context, index) {
//                     if (combinedVerses[index]['chapter']
//                         .toLowerCase()
//                         .contains(search.text.toLowerCase())) {
//                        return Column(
//                         children: [
//                           index == 0
//                               ? Stack(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.only(top: 0),
//                                 height: 140,
//                                 width: double.infinity,
//                                 decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage("assets/images/Group 3.png"),
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 102),
//                                   child: Center(
//                                     child: Text(
//                                       '${combinedVerses[index]['chapter']}',
//                                       style: const TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                               : Stack(
//                             children: [
//                               Container(
//                                 height: 100,
//                                 width: double.infinity,
//                                 decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage("assets/images/goldenframe.png"),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 4),
//                                   child: Center(
//                                     child: Text(
//                                       '${combinedVerses[index]['chapter']}',
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Text.rich(
//                             textAlign: TextAlign.center,
//                             TextSpan(
//
//                               children: _parseTextWithImages(combinedVerses[index]['verses']),
//                               style: TextStyle(
//
//                                 fontSize: 35,
//                                 height: 1.7,
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                               // textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       return Container();
//                     }
//
//                   },
//                 )
//                     : _pageNo[currentStatus],
//
//                 // HomeScreen(pages: pages, surahData : surahData, specificPageIndex:0, isQuranPage: true, ),
//
//                 //
//                 //QuranPage(pages, ),
//               ));
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
// }
//
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
//   TextStyle textStyle(Color color, String) {
//     return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w400);
//   }
// // TextStyle textStyle(Color color, String? fontFamily) {
// //   return TextStyle(fontSize: 10, color: color);
// // }
// }
