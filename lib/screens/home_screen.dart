import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consolePrintWithColor.dart';
import '../core/custom_toast.dart';
import '../core/index.dart';
import '../models/bookmark_model.dart';
import '../navbar/nav_bar.dart';
import '../providers/bookmark.dart';
import '../providers/bottom_navigation_provider.dart';
import '../providers/show_overlay_provider.dart';
import '../quran/page_data.dart';
import '../providers/quran.dart';
import '../widgets/custom_toast.dart';
import '../widgets/info_overlay/info_overlay.dart';
import '../widgets/marker.dart';
import '../widgets/page_number.dart';
import '../widgets/quran_page.dart';
import '../widgets/simple_page_info.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {


 // String language;
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool status = false;
  List<dynamic> quranData = [];
  List<dynamic> quranEnglish = [];
  List<dynamic> quranUrdu = [];
  List<dynamic> quranFrench = [];
  List<dynamic> quranSpanish = [];
  List<dynamic> quranRussian = [];
  String selectedItem = '';
  bool showBottomNavBar = true;
  bool showOverLay=false;


  List<int> bookMarksList=[];



Future<void> getQuranTras() async {
    final String quranEnglishResponce = await rootBundle.loadString('assets/qurandata.json');
    final data = await json.decode(quranEnglishResponce);
    quranData = data['data'];
    setState(() {
      quranData;
      isLoading = false;


    });


    debugPrint(quranEnglish.length.toString());
    setState(() {});

  }

  Future<void> getQuranTranslations() async {
    final String quranEnglishResponce = await rootBundle.loadString('assets/english.json');
    final data = await json.decode(quranEnglishResponce);
    quranEnglish = data['data'];
    setState(() {
      quranEnglish;
    });


    debugPrint(quranEnglish.length.toString());
    setState(() {});
    final String responseUrdu = await rootBundle.loadString('assets/urdu.json');
    final urdu = await json.decode(responseUrdu);
    quranUrdu = urdu['data'];
    setState(() {
      quranUrdu;
    });
    final String responseFrench = await rootBundle.loadString('assets/french.json');
    final french = await json.decode(responseFrench);
    quranFrench = french['data'];
    setState(() {
      quranFrench;
    });
     final String reponceSpanish = await rootBundle.loadString('assets/spanish.json');
    final spanish = await json.decode(reponceSpanish);
    quranSpanish = spanish['data'];
    setState(() {
      quranSpanish;
    });
     final String reponceRusian = await rootBundle.loadString('assets/russian.json');
    final rusian = await json.decode(reponceRusian);
    quranRussian = rusian['data'];
    setState(() {
      quranRussian;
    });


  }





  void toggleLanguage(String language) {
    setState(() {
      selectedItem = language;
    });
  }
  void showNestedPopupMenu(BuildContext context) {

  var bookMarkProvider=Provider.of<BookMarkProvider>(context,listen: false);

 final RenderBox button = context.findRenderObject() as RenderBox;
// Adjust the horizontal position

                                             

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        
    button.size.width / 2,
      -button.size.height - 10,
      button.size.width / 2,
      0,
    
    ),
      items: [
        PopupMenuItem<String>(
          value: 'Arabic',
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bookMarkProvider.selectedItem == 'Arabic' ? Color(0xffE4B452) : Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Arabic",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'English',
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bookMarkProvider.selectedItem == 'English' ? const Color(0xffE4B452) : Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "English",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Urdu',
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bookMarkProvider.selectedItem == 'urdu' ? Color(0xffE4B452) : Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Urdu",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'French',
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bookMarkProvider.selectedItem == 'French' ? Color(0xffE4B452) : Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "French",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Spanish',
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bookMarkProvider.selectedItem == 'Spanish' ? const Color(0xffE4B452) : Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Spanish",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Russian',
          child: Column(
            children: [
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bookMarkProvider.selectedItem == 'Russian' ? Color(0xffE4B452) : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(height: 10),
                      const Text(
                        "Russian",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
      elevation: 8,
    ).then((value) {
      if (value != null) {
        setState(() {
          bookMarkProvider.selectedItem = value;
        });
        //toggleLanguage;
        print('Selected nested menu item: $value');
      }
    });
  }
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;


  bool screenInitialized=false;
  initializeScreen()async{


    await getQuranTras();
    //print("language from bookmark ${    widget.language} ");
    if(selectedItem==''){
      selectedItem = 'Arabic';
    }

    await getQuranTranslations();
    controller = await AutoScrollController(
      //add this for advanced viewport boundary. e.g. SafeArea
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        //choose vertical/horizontal
        axis: scrollDirection,
        //this given value will bring the scroll offset to the nearest position in fixed row height case.
        //for variable row height case, you can still set the average height, it will try to get to the relatively closer offset
        //and then start searching.
        suggestedRowHeight: 200
    );

    Future.delayed(Duration(milliseconds: 1000),()async{
      await _scrollToCounter();
    });


    setState(() {
      screenInitialized=true;
    });
    print("init call");
  }
  void initState() {
    super.initState();
    initializeScreen();

    // selectedItem=Provider.of<Curr;

  }
  bool isbookMark = false;
 var bookmarkData;
  var currentData;
  @override
  Widget build(BuildContext context) {
    final bookMark = Provider.of<BookMarkProvider>(context,listen: false);
    final quran = Provider.of<QuranProvider>(context);
    final overlay = Provider.of<ShowOverlayProvider>(context, listen: false);
    final quranListenFalse = Provider.of<QuranProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final isLandscape = size.aspectRatio > 0.54;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final colorScheme = Theme.of(context).colorScheme;
    var provider=Provider.of<BottomNavigationProvider>(context);
    var updateProvider=Provider.of<BottomNavigationProvider>(context,listen: false);

  //   bool isNavShow = overlay.isShowOverlay;
    debugPrint('Hole rebuild');
    void _delay() async {
      await Future.delayed(Duration(milliseconds: 400));
      // overlay.toggleisShowOverlay();
      setState(() {
        showBottomNavBar = !showBottomNavBar;
      });
    }
    return SafeArea(

      child: GestureDetector(
        onTap: (){
          if(!showBottomNavBar && !showOverLay){
            setState(() {
              showBottomNavBar=true;
            });
          }else if(showBottomNavBar && !showOverLay){
            showBottomNavBar=false;
            showOverLay=true;
            setState(() {

            });
          }else if(!showBottomNavBar && showOverLay){
            setState(() {
              showBottomNavBar=false;
              showOverLay=false;
            });
          }
      // overlay.toggleisShowOverlay();
      //     _delay();
      // setState(() {
      //   showBottomNavBar = !showBottomNavBar;
      // });
    },
        child: Scaffold(
        //  bottomNavigationBar:
        //  showBottomNavBar?
        //  Stack(
        //    children: [
        //      StyleProvider(
        //        style: Style(),
        //        child: ConvexAppBar(

        //          backgroundColor:Colors.white,
        //          // shadowColor: Colors.white,
        //          initialActiveIndex:  provider.currentIndex ,
        //          onTap: (int value) {
        //            updateProvider.updateIndex(value);
        //            // setState(() {
        //            //   print("value ${value}");
        //            //   currentStatus = value;
        //            // });

        //          },
        //          height: 64,
        //          top: -27,
        //          // curveSize: 120,

        //          //curveSize:110,
        //          style: TabStyle.fixed,
        //          activeColor: iconColors,

        //          color:
        //          defaultColor,

        //          items: [
        //            TabItem(
        //                title: "Surahs",

        //                icon:
        //                Padding(
        //                  padding: const EdgeInsets.only(bottom: 4),
        //                  child: Image.asset(
        //                    'assets/images/Star-3.png',
        //                    color: provider.currentIndex == 0 ? iconColors : defaultColor,
        //                  ),
        //                )),
        //            TabItem(
        //                title: "Juz",
        //                icon: Padding(
        //                  padding: const EdgeInsets.only(bottom: 4),
        //                  child: Image.asset(
        //                    'assets/images/Star-3.png',
        //                    color: provider.currentIndex == 1 ? iconColors : defaultColor,
        //                  ),
        //                )),
        //            TabItem(
        //                title: "Holy Quran",
        //                icon: Padding(
        //                  padding:  const EdgeInsets.only(bottom: 4),
        //                  child: Image.asset(
        //                    'assets/icons/Star.png',
        //                    color: provider.currentIndex == 2 ? iconColors : defaultColor,
        //                  ),
        //                )),
        //            TabItem(
        //              title: "Bookmark",
        //              icon: Padding(
        //                padding:  const EdgeInsets.only(bottom: 4),
        //                child: Image.asset(

        //                  'assets/images/Save instagram.png',
        //                  //fit: BoxFit.cover,
        //                  color: provider.currentIndex == 3 ? iconColors : defaultColor,
        //                ),
        //              ),

        //            ),
        //            TabItem(title: "Settings",
        //              icon:
        //              Padding(
        //                padding:  const EdgeInsets.only(bottom: 4),
        //                child: Image.asset(
        //                  'assets/images/Settings.png',
        //                  color: provider.currentIndex == 4 ? iconColors : defaultColor,
        //                ),
        //              ),
        //            ),
        //          ],
        //          // backgroundColor: Colors.white,
        //        ),
        //      ),
        //      Padding(
        //        padding: const EdgeInsets.only(top: 64.0),
        //        child: Container(
        //          width: double.infinity,
        //          height: 20,
        //          color: Colors.white,
        //          // padding: const EdgeInsets.only(bottom: 30),
        //        ),
        //      ),
        //    ],
        //  ):null,
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
           //centerTitle: true,
           title:
                const Text(
             "Holy Quran",
             style: TextStyle(color: Colors.black),
           ),
           actions: <Widget>[

             Center(
               child: Text(
                 " القرآن الكريم",
                 style: TextStyle(color: Colors.black,fontSize: 18),
               ),
             ),


             PopupMenuButton<String>(
                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                 // constraints: const BoxConstraints.tightFor(height: 300),
                 // add icon, by default "3 dot" icon
                 icon: const Icon(
                   Icons.more_vert,
                   color: Colors.black,
                 ),
                 onSelected: (v) {
                   if (v == "trans") {
                     print("langiage");
                     isLoading==true? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Loading please wait"))):
                     showNestedPopupMenu(context);
                   }
                 },
                 itemBuilder: (context) {
                   return [
                     PopupMenuItem<String>(
                       value: 'trans',
                       child: Column(
                         children: [
                           Container(
                             height: 50,
                             //width: 200,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: Colors.white,
                             ),

                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 children: [
                                   const Expanded(
                                       child: Text(
                                         "Select Language",
                                         style: TextStyle(fontSize: 13),
                                       )),
                                   Text(
                                     ' ${bookMark.selectedItem}',
                                     style: TextStyle(fontSize: 13),
                                   ),
                                   const Icon(
                                     Icons.arrow_forward_ios,
                                     color: Colors.grey,
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(
                             height: 10,
                           ),
                         ],
                       ),
                     )
                   ];
                 })
           ],
         ),
          backgroundColor:
              isLandscape && size.width > 500 ? colorScheme.scaffoldBg : null,
          body:  bookMark.selectedItem != 'Arabic' && screenInitialized
              ? ListView.builder(
             controller: controller,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: quranData.length,
            itemBuilder: (context, index) {
              return AutoScrollTag(
                key: ValueKey(index),
                controller: controller,
                index: index,

                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(

                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                              onTap: ()async{
                                if(!bookMarksList.contains(index)){
                                  bookMarksList.add(index);
                                  print("index ${quranData.length}");
                                  print("select lang ${bookMark.selectedItem}");
                                  await  bookMark.setBookMarkForLanguage(context , index,bookMark.selectedItem.toString(), );
                                  setState(() {

                                  });
                                }


                              },
                              child: bookMarksList.contains(index) || Provider.of<BookMarkProvider>(context,listen: false).scrollIndex==index?
                              Icon(Icons.bookmark,color: Color(0xFFE4B452),size: 30,):
                              Icon(Icons.bookmark_border_rounded,color: Color(0xFFE4B452),size: 30,)
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10),
                            //   child: Image.asset('assets/images/Save instagram.png',height: 24,width: 38, color: iconColors,),
                            // )
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: IconButton(
                      //     onPressed: ()async{
                      //       await  bookMark.setBookMarkForLanguage(context , index,bookMark.selectedItem.toString() );
                      //
                      //
                      //
                      //       print("index ${quranData.length}");
                      //       print("select lang ${bookMark.selectedItem}");
                      //
                      //     },
                      //
                      //
                      //     icon: Icon(Icons.bookmark_outline, color: iconColors,)
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                quranData[index]['text'].toString(),
                                textAlign: TextAlign.center,


                                style: const TextStyle(
                                    fontSize: 23.2,
                                    fontFamily: "regular",
                                    ),
                                //maxLines: 1,
                              ),
                            ),
                            // SizedBox(width: 50,),
                          ],
                        ),
                      ),
                      bookMark.selectedItem != 'Arabic' && screenInitialized
                          ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  _getTranslationText(index),
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style:
                                  const TextStyle(fontSize: 18.2, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 30,
                              thickness: 3,
                            ),
                          ],
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
              );
            },
          )
              : bookMark.selectedItem != 'Arabic' && !screenInitialized?
              Center(child: SizedBox(height:20,width:20,child: CircularProgressIndicator()),):
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: isLandscape && size.width > 500
                      ? BoxDecoration(
                          border: Border.symmetric(
                            vertical: BorderSide(
                              color: colorScheme.infoText,
                              width: 2,
                            ),
                          ),
                          color: colorScheme.scaffold,
                        )
                      : null,
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: CarouselSlider.builder(
                    carouselController: quran.carouselController,
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        reverse: true,
                        height: double.infinity,
                        initialPage: quran.currentPage - 1,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged: (int newIndex, _) {
                          quranListenFalse.changePage(newIndex);
                        }),
                    itemCount: quranPages.length,
                    itemBuilder: (_, pageIndex, __) {
                      return isLandscape || isKeyboardOpen
                          ?
                      ListView(
                              children: [
                                const SimplePageInfo(),
                                QuranPage(pageIndex: pageIndex),
                              ],
                            )
                          : ListView(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               //const SimplePageInfo(),
                                QuranPage(pageIndex: pageIndex),
                                const PageNumber(),
                              ],
                            );
                    },
                  ),
                ),
                const Marker(),
                // if (!overlay.isShowOverlay) const CustomToast(),
                showOverLay?const InfoOverlay():SizedBox(),
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _scrollToCounter,
          //
          //   tooltip: 'Increment',
          //   child: Icon(Icons.add),
          // ),

        ),
      ),
    );

  }
  Future _scrollToCounter() async {
    Future.delayed(Duration(seconds: 1),()async{
      await controller.scrollToIndex(Provider.of<BookMarkProvider>(context,listen: false).scrollIndex,
          preferPosition: AutoScrollPosition.begin);
      controller.highlight(20);
    });

  }
  String _getTranslationText(int index) {
    switch (Provider.of<BookMarkProvider>(context,listen: false).selectedItem) {
      case 'English':
        return quranEnglish[index]['text'];
      case 'Urdu':
        return quranUrdu[index]['text'];
      case 'French':
        return quranFrench[index]['text'];
      case 'Spanish':
        return quranSpanish[index]['text'];
      case 'Russian':
        return quranRussian[index]['text'];
      case 'Russian':
        return quranRussian[index]['text'];
      default:
        return '';
    }
  }


}
