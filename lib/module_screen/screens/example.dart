// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// //
// // import 'package:page_flip/page_flip.dart';
// //
// // class QuranPage extends StatefulWidget {
// //   @override
// //   _QuranPageState createState() => _QuranPageState();
// // }
// //
// // class _QuranPageState extends State<QuranPage> {
// //   var quran = [];
// //   bool isLoading = true;
// //   final _controller = GlobalKey<PageFlipWidgetState>();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchQuranData();
// //     //  generatePages();
// //   }
// //
// //   String fullText = '';
// //   fetchQuranData() async {
// //     var request =
// //     http.Request('GET', Uri.parse('http://43.204.244.182/api/v1/complete-quran'));
// //
// //     http.StreamedResponse response = await request.send();
// //
// //     if (response.statusCode == 200) {
// //       var res = await response.stream.bytesToString();
// //       var body = jsonDecode(res);
// //       setState(() {
// //         quran = body['data']['chapters'];
// //         isLoading = false;
// //         //for()
// //       });
// //     } else {
// //       print(response.reasonPhrase);
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }
// //   List<String> pages = [];
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: isLoading
// //             ? const Center(child: CircularProgressIndicator())
// //             :  ListView.builder(
// //             itemCount: quran.length,
// //             itemBuilder: (context, index) {
// //               return Column(
// //                 children: [
// //                   index ==0?
// //                   Stack(
// //                     children: [
// //                       Container(
// //                         height: 140,
// //                         //   height: 150,
// //                         width: double.infinity,
// //                         decoration: const BoxDecoration(
// //                           image: DecorationImage(
// //                               image: AssetImage(
// //
// //                                   "assets/images/Group 3.png"
// //                               ),
// //                               fit: BoxFit.fill
// //                           ),
// //                         ),
// //                       ),
// //                       Positioned.fill(
// //                         top: 105,
// //                         child: Center(
// //                           child: Text(quran[index]['arabicname'], style: const TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.black87,
// //                           ),),
// //                         ),
// //                       ),
// //
// //                     ],
// //                   ):
// //
// //                   Stack(
// //                     children: [
// //                       Container(
// //                         height: 100,
// //                         //   height: 150,
// //                         width: double.infinity,
// //                         decoration: const BoxDecoration(
// //                           image: DecorationImage(
// //                             image: AssetImage(
// //
// //                                 "assets/images/goldenframe.png"
// //                             ),
// //                             //fit: BoxFit.fill
// //                           ),
// //                         ),
// //                       ),
// //                       Positioned.fill(
// //                         top: 5,
// //                         child: Center(
// //                           child: Text(quran[index]['arabicname'], style: const TextStyle(
// //                             // fontFamily: 'Kitab',
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.black87,
// //                           ),),
// //                         ),
// //                       ),
// //
// //                     ],
// //                   ),
// //                   Text(
// //
// //                     quran[index]['verses']['text'],
// //                     style: const TextStyle(
// //                       fontSize: 22,
// //                       color: Colors.black87,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //
// //                 ],);
// //             })
// //
// //     );
// //   }
// // }
// //
// // class DemoPage extends StatefulWidget {
// //   var page ;
// //
// //   DemoPage({required this.page});
// //
// //   @override
// //   _DemoPageState createState() => _DemoPageState();
// // }
// //
// // class _DemoPageState extends State<DemoPage> {
// //
// //   //int currentPage = 0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // generatePages();
// //   }
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         bottom: false,
// //         child: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Text(
// //
// //             widget.page,
// //             style: const TextStyle(
// //               // fontFamily: 'Kitab',
// //               fontSize: 22,
// //               color: Colors.black87,
// //             ),
// //             textAlign: TextAlign.center,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:page_flip/page_flip.dart';
//
// class QuranPage extends StatefulWidget {
//   @override
//   _QuranPageState createState() => _QuranPageState();
// }
//
// class _QuranPageState extends State<QuranPage> {
//
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//
//   List<String> pages = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : HomeScreen(pages),
//     );
//   }
// }
//
// class Quran extends StatefulWidget {
//   final String page;
//
//   Quran(this.page);
//
//   @override
//   State<Quran> createState() => _QuranState();
// }
//
// class _QuranState extends State<Quran> {
//   @override
//   void initState() {
//     super.initState();
//     print("QuranPage page ${widget.page.length}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final parts = widget.page.split('\n');
//
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white,
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.white,
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: ListView.builder(
//             itemCount: (parts.length / 2).ceil(),
//             itemBuilder: (context, index) {
//               final verseName = parts[index * 2];
//               final verseText = (index * 2 + 1) < parts.length ? parts[index * 2 + 1] : '';
//               return Column(
//                 children: [
//                   index ==0?
//                   Stack(
//                     children: [
//                       Container(
//                         height: 140,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/Group 3.png"),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       Positioned.fill(
//                         top: 105,
//                         child: Center(
//                           child: Text(
//                              verseName,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ) :
//                   Stack(
//                     children: [
//                       Container(
//                         height: 100,
//                         //   height: 150,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(
//
//                                 "assets/images/goldenframe.png"
//                             ),
//                             //fit: BoxFit.fill
//                           ),
//                         ),
//                       ),
//                       Positioned.fill(
//                         top: 5,
//                         child: Center(
//                           child: Text(verseName, style: TextStyle(
//                             // fontFamily: 'Kitab',
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   Text(
//                     verseText,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 19.8),
//                   ),
//
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class HomeScreen extends StatefulWidget {
//   final List<String> pages;
//
//   HomeScreen(this.pages, {Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _controller = GlobalKey<PageFlipWidgetState>();
//   @override
//   void initState() {
//     super.initState();
//     print("flip page ${widget.pages.length}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageFlipWidget(
//         key: _controller,
//         backgroundColor: Colors.white,
//         lastPage: Container(
//           color: Colors.white,
//           child: Center(child: Text('Last Page!')),
//         ),
//         children: <Widget>[
//           ...widget.pages.map((page) => Quran(page)).toList(),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
