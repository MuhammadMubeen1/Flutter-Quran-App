// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
//
//
// class QuranPageFrame extends StatefulWidget {
//   final String page;
//   final int currentPage;
//   final int totalPageCount;
//   var nameArabic;
//
//   QuranPageFrame(
//     this.page, {
//     required this.currentPage,
//     required this.totalPageCount,
//     required this.nameArabic,
//   });
//
//   @override
//   State<QuranPageFrame> createState() => _QuranPageFrameState();
// }
//
// class _QuranPageFrameState extends State<QuranPageFrame> {
//   bool _isLoading = true;
//   List<Map<String, dynamic>> _journals = [];
//   void _refreshJournals() async {
//     final data = await SQLHelper.getItems();
//     setState(() {
//       _journals = data;
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _addItem() async {
//     await SQLHelper.createItem(
//       "Holy Quran",
//       widget.currentPage.toInt(),
//       widget.nameArabic.toString(),
//     );
//
//     Fluttertoast.showToast(
//       msg: "Successfully Save as BoolMark!",
//     );
//     _refreshJournals();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     print("QuranPage page ${widget.page.length}");
//     print("currentPage ${widget.currentPage}");
//     // print("current  ${widget.page}");
//   }
//
//   bool visible = false;
//   bool isLoading = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // Handle onTap logic here
//                 _addItem();
//                 print("Clicked on bookmark");
//               },
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Visibility(
//                   visible: visible,
//                   child: Card(
//                     color: Colors.white,
//                     elevation: 5,
//                     child: Container(
//                       color: Colors.white,
//                       height: 85,
//                       width: double.infinity,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.grey.shade200,
//                             ),
//                             height: 30,
//                             width: 170,
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       'Page ${widget.currentPage + 1} / ${widget.totalPageCount}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           InkWell(
//                             onTap: () {
//
//                               // This onTap will be triggered only if the GestureDetector's onTap is not triggered.
//                               print("Inner InkWell clicked");
//                             },
//                             child: Image.asset(
//                               'assets/images/Save instagram.png',
//                               height: 30,
//                               width: 30,
//                               color: defaultColor,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//
//             // Align(
//             //   alignment: Alignment.bottomCenter,
//             //   child: Visibility(
//             //     visible: visible,
//             //     child: Card(
//             //       color: Colors.white,
//             //       elevation: 5,
//             //       child: AbsorbPointer(
//             //         child: Container(
//             //           color: Colors.white,
//             //           height: 85,
//             //           width: double.infinity,
//             //           child: Row(
//             //             mainAxisAlignment: MainAxisAlignment.center,
//             //             children: [
//             //               Container(
//             //                 decoration: BoxDecoration(
//             //                   borderRadius: BorderRadius.circular(10),
//             //                   color: Colors.grey.shade200,
//             //                 ),
//             //                 height: 30,
//             //                 width: 170,
//             //                 child: Center(
//             //                   child: Row(
//             //                     mainAxisAlignment: MainAxisAlignment.center,
//             //                     children: [
//             //                       Center(
//             //                         child: Text(
//             //                           'Page ${widget.currentPage + 1} / ${widget.totalPageCount}',
//             //                           style: const TextStyle(
//             //                             fontWeight: FontWeight.bold,
//             //                           ),
//             //                         ),
//             //                       ),
//             //                     ],
//             //                   ),
//             //                 ),
//             //               ),
//             //               const SizedBox(
//             //                 width: 10,
//             //               ),
//             //               InkWell(
//             //                 onTap: () {
//             //                   _addItem();
//             //                   print("click on bookmark ");
//             //                 },
//             //                 child: Image.asset(
//             //                   'assets/images/Save instagram.png',
//             //                   height: 30,
//             //                   width: 30,
//             //                   color: defaultColor,
//             //                 ),
//             //               ),
//             //               const SizedBox(
//             //                 width: 10,
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             GestureDetector(
//                 onTap: () {
//                  // _addItem();
//                   setState(() {
//                     //   visible =true;
//                     visible = !visible;
//                     print('visible');
//                   });
//                 },
//                 child: Text(
//                       textAlign: TextAlign.center,
//
//                       widget.page,
//                       // textAlign: TextAlign.center,
//                   style:  TextStyle(
//                     fontSize: 33,
//                     wordSpacing: 4,
//                     height: 1.7,
//                     // fontFamily: "Kitab",
//                     color: Colors.black.withOpacity(0.6),
//                     //fontWeight: FontWeight.w200,
//                   ),
//                     ),
//                   ),
//           ]
//                 ),
//
//         ),
//       );
//
//   }
// }
//
// class QuranFrame extends StatefulWidget {
//   List<String> pages;
//   final int specificPageIndex;
//   final currentSurah;
//   int chapter;
//   String totalVerse;
//
//   QuranFrame({
//     required this.pages,
//     required this.specificPageIndex,
//     required this.currentSurah,
//     required this.chapter,
//     required this.totalVerse,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<QuranFrame> createState() => _QuranFrameState();
// }
//
// class _QuranFrameState extends State<QuranFrame> {
//   final PageController _pageController = PageController(viewportFraction: 0.9);
//   int currentPageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _pageController.addListener(_pageListener);
//     print("flip page ${widget.pages.length}");
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _pageController.jumpToPage(widget.specificPageIndex);
//     });
//   }
//
//   void _pageListener() {
//     setState(() {
//       currentPageIndex = _pageController.page!.round();
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.removeListener(_pageListener);
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   int bookMarkPage = 0;
//   bool isSurah = false;
//   String selectedItem = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         bookMarkPage == 0 || bookMarkPage == null
//             ? Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 22),
//                     child: Container(
//                       height: 170,
//                       //   height: 150,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                             "assets/images/Group 3.png",
//                           ),
//                           // fit: BoxFit.cover
//                         ),
//                       ),
//
//                     ),
//                   ),
//                   //  child: Image.asset("assets/images/frame.png", height: 270,width: double.infinity,)),
//                   Positioned.fill(
//                     top: 155,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.currentSurah,
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned.fill(
//                     top: 161,
//                     right: 250,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.totalVerse.contains("-")
//                                 ? "ver :${widget.totalVerse.toString()}"
//                                 : "verse :${widget.totalVerse.toString()}",
//                             style: const TextStyle(
//                               fontSize: 10,
//                             ),
//                           ),
//                           // Text(
//                           //   "Chapter ${widget.chapter.toString()}",
//                           //   style: TextStyle(
//                           //     fontSize: 18,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned.fill(
//                     top: 160,
//                     left: 250,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             "page :${bookMarkPage + 1}",
//                             style: const TextStyle(
//                               fontSize: 9,
//                             ),
//                           ),
//                           // Text(
//                           //   "Chapter ${widget.chapter.toString()}",
//                           //   style: TextStyle(
//                           //     fontSize: 18,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             : Container(),
//         // Padding(
//         //         padding:
//         //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         //         child: Column(
//         //           children: [
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //               children: [
//         //                 Text(
//         //                   "Chapter ${widget.chapter.toString()}",
//         //                   style: const TextStyle(
//         //                     fontSize: 18,
//         //                   ),
//         //                 ),
//         //                 Text(
//         //                   '${bookMarkPage + 1}',
//         //                   // widget.currentSurah,
//         //                   style: const TextStyle(
//         //                     fontSize: 18,
//         //                     fontWeight: FontWeight.bold,
//         //                   ),
//         //                 ),
//         //               ],
//         //             )
//         //           ],
//         //         ),
//         //       ),
//         Expanded(
//           child: Center(
//             child: PageFlipWidget(
//               itemCount: widget.pages.length,
//               itemBuilder: (context, index) {
//                 return QuranPageFrame(
//                   widget.pages[index],
//                   currentPage: index,
//                   totalPageCount: widget.pages.length,
//                   nameArabic: widget.currentSurah,
//                 );
//               },
//               scrollDirection: Axis.horizontal,
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentPageIndex = index;
//                   bookMarkPage = currentPageIndex;
//                 });
//               },
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }
//
// class PageFlipWidget extends StatefulWidget {
//   final int itemCount;
//   final IndexedWidgetBuilder itemBuilder;
//   final Axis scrollDirection;
//   final ValueChanged<int>? onPageChanged;
//   final PageController controller;
//
//   PageFlipWidget({
//     required this.itemCount,
//     required this.itemBuilder,
//     this.scrollDirection = Axis.horizontal,
//     this.onPageChanged,
//     required this.controller,
//   });
//
//   @override
//   _PageFlipWidgetState createState() => _PageFlipWidgetState();
// }
//
// class _PageFlipWidgetState extends State<PageFlipWidget> {
//   double? _currentPage;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_pageListener);
//   }
//
//   @override
//   void dispose() {
//     widget.controller.removeListener(_pageListener);
//     super.dispose();
//   }
//
//   void _pageListener() {
//     setState(() {
//       _currentPage = widget.controller.page;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       reverse: true,
//       itemCount: widget.itemCount,
//       controller: widget.controller,
//       onPageChanged: widget.onPageChanged,
//       itemBuilder: (context, index) {
//         final currentPage =
//             _currentPage ?? widget.controller.initialPage.toDouble();
//         final delta = index - currentPage;
//         double angle = delta * math.pi / 2; // 90 degrees in radians
//         double scaleFactor = (1 - delta.abs() * 0.2).clamp(0.0, 1.0);
//
//         // Define the padding based on the scroll direction
//         EdgeInsetsGeometry pagePadding =
//             widget.scrollDirection == Axis.horizontal
//                 ? EdgeInsets.only(right: delta < 0 ? 5 : 0)
//                 : EdgeInsets.only(bottom: delta < 0 ? 5 : 0);
//
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
//           child: Transform(
//             alignment: widget.scrollDirection == Axis.horizontal
//                 ? Alignment.centerRight
//                 : Alignment.bottomCenter,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..translate(
//                 widget.scrollDirection == Axis.horizontal
//                     ? -delta.abs() * 200
//                     : 0.0,
//                 widget.scrollDirection == Axis.horizontal
//                     ? 0.0
//                     : -delta.abs() * 200,
//               )
//               ..rotateY(angle),
//             child: Transform.scale(
//               scale: scaleFactor,
//               alignment: widget.scrollDirection == Axis.horizontal
//                   ? Alignment.centerLeft
//                   : Alignment.topCenter,
//               child: Container(
//                 width: double.infinity, // Make the page full width
//                 padding: pagePadding,
//                 child: widget.itemBuilder(context, index),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
