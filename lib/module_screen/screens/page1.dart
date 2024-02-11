// // import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_flip_panel/flutter_flip_panel.dart';

// class QuranPage extends StatefulWidget {
//   final List<String> pages;
//   final PageController pageController;

//   QuranPage(this.pages, this.pageController);

//   @override
//   State<QuranPage> createState() => _QuranPageState();
// }

// class _QuranPageState extends State<QuranPage> {
//   bool visible = false;
//   bool isLoading = true;
//   GlobalKey<FlipPanelState> _flipPanelKey = GlobalKey<FlipPanelState>();
//   Offset _oldPosition = Offset.zero;

//   @override
//   void initState() {
//     super.initState();
//     // Simulate loading data for 2 seconds
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         isLoading = false; // Mark loading as complete
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.lightGreen.withOpacity(0.800),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             FlipPanel.builder(
//               key: _flipPanelKey,
//               controller: widget.pageController,
//               itemCount: widget.pages.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     // Your existing content here
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           visible = !visible;
//                           print('visible');
//                         });
//                       },
//                       onHorizontalDragStart: (details) {
//                         _oldPosition = details.globalPosition;
//                         _flipPanelKey.currentState?.startFlip();
//                       },
//                       onHorizontalDragUpdate: (details) {
//                         Offset off = details.globalPosition - _oldPosition;
//                         double tilt = 1 / _clampMin((-off.dy + 20) / 100);
//                         double percent = _clampPercent(-off.dx / MediaQuery.of(context).size.width * 1.4, tilt);
//                         _flipPanelKey.currentState?.flip(percent, tilt);
//                       },
//                       onHorizontalDragEnd: (details) {
//                         _flipPanelKey.currentState?.stopFlip();
//                       },
//                       onHorizontalDragCancel: () {
//                         _flipPanelKey.currentState?.stopFlip();
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             // Show the loading bar if data is still loading
//             if (isLoading)
//               Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   double _clampMin(double v) {
//     const double _MinNumber = 0.008;
//     if (v < _MinNumber && v > -_MinNumber) {
//       if (v >= 0) {
//         v = _MinNumber;
//       } else {
//         v = -_MinNumber;
//       }
//     }
//     return v;
//   }

//   double _clampPercent(double percent, double tilt) {
//     if (percent > 0.5) {
//       percent = 1;
//     } else {
//       percent = 0;
//     }
//     return percent;
//   }
// }
