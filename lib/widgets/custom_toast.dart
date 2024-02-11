// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/quran.dart';
// import '../providers/toast.dart';

// class CustomToast extends StatelessWidget {
//   const CustomToast({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final quran = Provider.of<QuranProvider>(context);
//     final toast = Provider.of<ToastProvider>(context);

//     return IgnorePointer(
//       child: AnimatedOpacity(
//         duration: const Duration(milliseconds: 200),
//         opacity: toast.opacity,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.black87,
//           ),
//           child: Text(
//             "",
//             // quran.hizbText,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 17,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
