import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/bottom_navigation_provider.dart';
import 'package:untitled/screens/search_surah.dart';
import '../providers/bookmark.dart';
import '../providers/show_overlay_provider.dart';
import '../quran/quran.dart';

import '../core/index.dart';
import '../providers/quran.dart';

import '../widgets/surah_number.dart';


class IndexScreen extends StatefulWidget {
  final bool? navigateFromQuranIndex;
  const IndexScreen({this.navigateFromQuranIndex=false,Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  ScrollController _controller = ScrollController();
  bool _isKeyboardVisible = false;
  TextEditingController search = TextEditingController();
  bool isSearching = false;
  void _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isKeyboardVisible) {
        FocusScope.of(context).unfocus();
      }
      _isKeyboardVisible = false;
    } else if (_controller.position.userScrollDirection ==
        ScrollDirection.forward) {
      _isKeyboardVisible = true;
    }
  }
  @override
  void initState() {

    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<BottomNavigationProvider>(context, listen: false);
    final quran = Provider.of<QuranProvider>(context, listen: false);
    final bookMark = Provider.of<BookMarkProvider>(context);
    final overlay = Provider.of<ShowOverlayProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
   // final carouselController = CarouselController();
    final textStyle = TextStyle(
      color: colorScheme.juzCardText,
      fontSize: 15,
    );

    void _goToBookMark() {
      quran.goToPage(bookMark.markPage);
      overlay.toggleisShowOverlay();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:
        isSearching
            ? GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: TextFormField(
            autocorrect: false,
            enableSuggestions: false,
            autofocus: true,
            controller: search,
            onChanged: (val) {
              setState(() {});
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Surah',
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        )
            : const Text(
          "Surahs",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchSurah()));
              // FocusScope.of(context).unfocus();
              // setState(() {
              //
              //   isSearching = !isSearching;
              // });
            },
            child: Icon(
              Icons.search,
              color: defaultColor,
              size: 28,
            ),
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      body:  GestureDetector(
        onTap: () {
          if (_isKeyboardVisible) {
            FocusScope.of(context).unfocus();
          }
        },
        child:
             ListView.separated(
          controller: _controller,
          itemBuilder: (context, index) {
            final surahNumber = index + 1;
            final page = getSurahFirstPage(surahNumber);
            if (getSurahNameEnglish(surahNumber)
                .toLowerCase()
                .contains(search.text.toLowerCase())) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: GestureDetector(
                  onTap: ()async{

                    // const HomeScreen();
                    if(widget.navigateFromQuranIndex!=null && widget.navigateFromQuranIndex!) {
                      Navigator.of(context).pop();
                      quran.goToPage(page - 1);
                    }else{
                      await indexProvider.updateIndex(2);
                      print(page);
                      Future.delayed(const Duration(milliseconds: 300),(){
                        quran.goToPage(page - 1);
                        print("going");
                      });

                    }

                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200),
                    child: Column(
                      children: [
                        ListTile(

                        //  leading:Text(get),
                          title: Text(
                            "سُوْرَةُ " + getSurahNameArabic(surahNumber),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                          subtitle: Text(
                              getSurahNameEnglish(surahNumber),
                         //   getSurahData(surahNumber),
                          ),
                          trailing: Text(
                              //getPlaceMakiMadni(surahNumber),
                           getSurahData(surahNumber),
                           // '$page',
                            style: TextStyle(color: trailingColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (context, index) => Container(),
               itemCount: 114,
        ),
      ),






      // ListView.separated(
      //   itemCount: 114,
      //   separatorBuilder: (context, index) {
      //     return  Container();
      //   },
      //   itemBuilder: (BuildContext context, int index) {
      //     final surahNumber = index + 1;
      //     final page = getSurahFirstPage(surahNumber);
      //     return Stack(
      //       children: [
      //         Container(
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(20),
      //               color: Colors.grey.shade200),
      //           child: Column(
      //             children: [
      //               ListTile(
      //                 onTap: ()async{
      //
      //                   // const HomeScreen();
      //                   if(widget.navigateFromQuranIndex!=null && widget.navigateFromQuranIndex!) {
      //                     Navigator.of(context).pop();
      //                     quran.goToPage(page - 1);
      //                   }else{
      //                     await indexProvider.updateIndex(2);
      //                     print(page);
      //                     Future.delayed(const Duration(milliseconds: 300),(){
      //                       quran.goToPage(page - 1);
      //                       print("going");
      //                     });
      //
      //                   }
      //
      //                 },
      //                 //visualDensity: const VisualDensity(horizontal: -3),
      //                 leading:Text(surahNumber.toString()),
      //                 //SurahNumber(number: surahNumber),
      //                 title: Text(
      //                   "سُوْرَةُ " + getSurahNameArabic(surahNumber),
      //                   style: const TextStyle(
      //                     fontFamily: AppTheme.secondaryFontFamily,
      //                     fontSize: 25,
      //                     fontWeight: FontWeight.bold,
      //                     height: 1.2,
      //                   ),
      //                 ),
      //                 subtitle: Text(
      //                   getSurahData(surahNumber),
      //                   style: const TextStyle(
      //                     fontSize: 15,
      //                   ),
      //                 ),
      //                 trailing: Text(
      //                   '$page',
      //                   style: TextStyle(
      //                     fontSize: 21,
      //                     color: colorScheme.pageNumber,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         if (isMarkedSurah(bookMark.markPage, surahNumber))
      //           const Marker(left: 60),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
