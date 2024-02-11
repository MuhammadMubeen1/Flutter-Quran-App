import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:untitled/consolePrintWithColor.dart';

import '../core/app_color.dart';
import '../providers/bottom_navigation_provider.dart';
import '../providers/quran.dart';
import '../quran/quran.dart';

class SearchSurah extends StatefulWidget {
  final bool? navigateFromQuranIndex;

  const SearchSurah({this.navigateFromQuranIndex = false, Key? key}) : super(key: key);

  @override
  State<SearchSurah> createState() => _SearchSurahState();
}

class _SearchSurahState extends State<SearchSurah> {
  ScrollController _controller = ScrollController();
  bool _isKeyboardVisible = false;
  TextEditingController search = TextEditingController();

  // String search = "dcscs";
  bool isSearching = false;

  void _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isKeyboardVisible) {
        FocusScope.of(context).unfocus();
      }
      _isKeyboardVisible = false;
    } else if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      _isKeyboardVisible = true;
    }
  }

  @override
  void initState() {
    search.text = "";
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        //backgroundColor: Colors.white,
        title: Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              autofocus: false,
              controller: search,
              decoration: InputDecoration(
                hintText: 'Search, Surah',
                prefixIcon: Icon(Icons.search, color:Colors.grey[400]! ,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide(
                    color: Colors.grey[400]!, // Border color
                    width: 0, // Decreased border thickness
                  ),

                ),
              //  enabledBorder: ,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 0, color: Colors.grey[400]!
                  ), //<-- SEE HERE
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),//<-- SEE HERE
                  borderSide: BorderSide(
                      width: 3, color: Colors.redAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide(
                      width: 0, color: Colors.grey[400]!),
                ),

                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 20),
          search.text == ""
              ? Column(
                  children: [
                    Text(
                      "Try searching with :",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Surah Al-Fateha',
                      style: TextStyle(color: iconColors, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'سيقول السفهاء',
                      style: TextStyle(color: iconColors, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Surah Al-Baqarah',
                      style: TextStyle(color: iconColors, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'سيقول السفهاء',
                      style: TextStyle(color: iconColors, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 20),
          search.text == ""
              ? Container()
              : Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_isKeyboardVisible) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      controller: _controller,
                      itemBuilder: (context, index) {
                        final surahNumber = index + 1;
                        final page = getSurahFirstPage(surahNumber);
                        if (getSurahNameEnglish(surahNumber).toLowerCase().contains(search.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: GestureDetector(
                              onTap: () async {
                                // const HomeScreen();
                                printLog("========>Search result clicked");
                                if (widget.navigateFromQuranIndex != null && widget.navigateFromQuranIndex!) {

                                  Navigator.pop(context);
                                  await indexProvider.updateIndex(2);
                                  print(page);
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    quran.goToPage(page - 1);
                                    print("going");
                                  });
                                  // Navigator.of(context).pop();
                                  // quran.goToPage(page - 1);
                                } else {
                                  Navigator.pop(context);
                                  await indexProvider.updateIndex(2);
                                  print(page);
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    quran.goToPage(page - 1);
                                    print("going");
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                                child: Column(
                                  children: [
                                    ListTile(
                                      //  leading:Text(get),
                                      title: Text(
                                        "سُوْرَةُ " + getSurahNameArabic(surahNumber),
                                        style:
                                            TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
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
                ),
        ],
      ),
    );
  }
}
