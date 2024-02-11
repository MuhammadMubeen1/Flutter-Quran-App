
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_color.dart';
import '../module_screen/screens/bookmark/bookmark.dart';
import '../module_screen/screens/juzz/juz.dart';
import '../module_screen/screens/settings.dart';
import '../providers/bottom_navigation_provider.dart';
import '../providers/show_overlay_provider.dart';
import '../screens/home_screen.dart';
import '../screens/index_screen.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int currentStatus = 0;
  final _pageNo = [
    const IndexScreen(),
    const JuzScreen(),
     HomeScreen(),
   const BookMark(),
    const SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<BottomNavigationProvider>(context);
    var updateProvider=Provider.of<BottomNavigationProvider>(context,listen: false);
    final overlay = Provider.of<ShowOverlayProvider>(context, listen: false);
    return Scaffold(
      body:
      _pageNo[provider.currentIndex],
      bottomNavigationBar:
      // provider.currentIndex == 2?null:
    // overlay.isShowOverlay? null:
      Stack(
        children: [
          StyleProvider(
            style: Style(),
            child: ConvexAppBar(

              backgroundColor:Colors.white,
              // shadowColor: Colors.white,
              initialActiveIndex:  provider.currentIndex ,
              onTap: (int value) {
                updateProvider.updateIndex(value);
                // setState(() {
                //   print("value ${value}");
                //   currentStatus = value;
               },
              height: 64,
              top: -27,
              // curveSize: 120,

              //curveSize:110,
              style: TabStyle.fixed,
              activeColor: iconColors,

              color:
                defaultColor,

              items: [
                TabItem(
                    title: "Surahs",

                    icon:
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Image.asset(
                        'assets/images/Star-3.png',
                        color: provider.currentIndex == 0 ? iconColors : defaultColor,
                      ),
                    )),
                TabItem(
                    title: "Juz",
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Image.asset(
                        'assets/images/Star-3.png',
                        color: provider.currentIndex == 1 ? iconColors : defaultColor,
                      ),
                    )),
                TabItem(
                    title: "Holy Quran",
                    icon: Padding(
                      padding:  const EdgeInsets.only(bottom: 4),
                      child: Image.asset(
                        'assets/icons/Star.png',
                        color: provider.currentIndex == 2 ? iconColors : defaultColor,
                      ),
                    )),
                TabItem(
                  title: "Bookmark",
                  icon: Padding(
                    padding:  const EdgeInsets.only(bottom: 4),
                    child: Image.asset(

                      'assets/images/Save instagram.png',
                      //fit: BoxFit.cover,
                      color: provider.currentIndex == 3 ? iconColors : defaultColor,
                    ),
                  ),

                ),
                TabItem(title: "Settings",
                  icon:
                  Padding(
                    padding:  const EdgeInsets.only(bottom: 4),
                    child: Image.asset(
                      'assets/images/Settings.png',
                      color: provider.currentIndex == 4 ? iconColors : defaultColor,
                    ),
                  ),
                ),
              ],
              // backgroundColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: Container(
              width: double.infinity,
              height: 20,
              color: Colors.white,
              // padding: const EdgeInsets.only(bottom: 30),
            ),
          ),
        ],
      ),         // });

      
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 60;

  @override
  double get activeIconMargin => 0;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color , String) {
    return TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w400);
  }
// TextStyle textStyle(Color color, String? fontFamily) {
//   return TextStyle(fontSize: 10, color: color);
// }
}



