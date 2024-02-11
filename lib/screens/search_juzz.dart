import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/app_color.dart';
import '../providers/bottom_navigation_provider.dart';
import '../providers/quran.dart';
import '../quran/quran.dart';

class SearchJuzz extends StatefulWidget {
  final bool? navigateFromQuranIndex;

  const SearchJuzz({this.navigateFromQuranIndex = false, Key? key}) : super(key: key);

  @override
  State<SearchJuzz> createState() => _SearchJuzzState();
}

class _SearchJuzzState extends State<SearchJuzz> {
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
    readJson();
    search.text = "";
    _controller.addListener(_scrollListener);
    super.initState();
  }
  bool isLoading = true;
  List<dynamic> quranData = [];
  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/juz.json');
    final data = await json.decode(response);
    quranData = data['data'];
    setState(() {
      quranData;
      isLoading = false;
    });
    debugPrint(quranData.length.toString());
    setState(() {});
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
                hintText: 'Search, Juzz',
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

            child: isLoading? const Center(child: CircularProgressIndicator()):
            ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: quranData.length,

                  itemBuilder: (context, index){
                    final surahNumber = index + 1;
                    final page = getSurahFirstPage(surahNumber);
                    if (
                    quranData[index]['start']['chapter_name']
                        .toLowerCase()
                        .contains(search.text.toLowerCase())) {
                      return GestureDetector(
                        onTap: ()async{

                          if(surahNumber ==1){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(page - 1);
                              print("going");
                            });
                          } else if(surahNumber ==2){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(21);
                              print("going");
                            });
                          }else if(surahNumber ==3){
                            Navigator.pop(context);

                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(41);
                              print("going");
                            });
                          }else if(surahNumber ==4){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(61);
                              print("going");
                            });
                          }
                          else if(surahNumber ==5){
                            Navigator.pop(context);

                            await indexProvider.updateIndex(2);

                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(81);
                              print("going");
                            });
                          }   else if(surahNumber ==6){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(101);
                              print("going");
                            });
                          }
                          else if(surahNumber ==7){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(120);
                              print("going");
                            });
                          }
                          else if(surahNumber ==8){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(141);
                              print("going");
                            });
                          }
                          else if(surahNumber ==9){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(161);
                              print("going");
                            });
                          }
                          else if(surahNumber ==10){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(181);
                              print("going");
                            });
                          }
                          else if(surahNumber ==11){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(200);
                              print("going");
                            });
                          }
                          else if(surahNumber ==12){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(221);
                              print("going");
                            });
                          }
                          else if(surahNumber ==13){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(241);
                              print("going");
                            });
                          }
                          else if(surahNumber ==14){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(261);
                              print("going");
                            });
                          }
                          else if(surahNumber ==15){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(281);
                              print("going");
                            });
                          }
                          else if(surahNumber ==16){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(301);
                              print("going");
                            });
                          }
                          else if(surahNumber ==17){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(321);
                              print("going");
                            });
                          }
                          else if(surahNumber ==18){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(341);
                              print("going");
                            });
                          }
                          else if(surahNumber ==19){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(361);
                              print("going");
                            });
                          }
                          else if(surahNumber ==20){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(381);
                              print("going");
                            });
                          }
                          else if(surahNumber ==21){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(401);
                              print("going");
                            });
                          }
                          else if(surahNumber ==22){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(421);
                              print("going");
                            });
                          }
                          else if(surahNumber ==23){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(441);
                              print("going");
                            });
                          }
                          else if(surahNumber ==24){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(461);
                              print("going");
                            });
                          }
                          else if(surahNumber ==25){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(481);
                              print("going");
                            });
                          }
                          else if(surahNumber ==26){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(501);
                              print("going");
                            });
                          }
                          else if(surahNumber ==27){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(521);
                              print("going");
                            });
                          }
                          else if(surahNumber ==28){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(541);
                              print("going");
                            });
                          }
                          else if(surahNumber ==29){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(561);
                              print("going");
                            });
                          }
                          else if(surahNumber ==30){
                            Navigator.pop(context);
                            await indexProvider.updateIndex(2);
                            print(page);
                            Future.delayed(const Duration(milliseconds: 300),(){
                              quran.goToPage(581);
                              print("going");
                            });
                          }

                        },

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                          child: Column(
                            children: [
                              Row(
                                children:  [
                                  Text(
                                    "Juz ${quranData[index]['juz']}",
                                    style:const  TextStyle(color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                                child: Column(
                                  children:  [
                                    ListTile(
                                      title: Text(
                                        quranData[index]['start']['chapter_arabicname'],
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                                      ),
                                      subtitle: Text(quranData[index]['start']['chapter_name'],),
                                      trailing: Text(
                                        '${quranData[index]['start']['verse']} Verses',
                                        style: const TextStyle(color: trailingColor),
                                      ),
                                    ),
                                    const  Divider(
                                      color: Colors.grey,
                                    ),
                                    ListTile(
                                      title: Text(
                                        quranData[index]['end']['chapter_arabicname'],
                                        style:const  TextStyle(color: Colors.black,
                                            fontWeight: FontWeight.w400, fontSize: 14),
                                      ),
                                      subtitle: Text(quranData[index]['end']['chapter_name']),
                                      trailing: Text(
                                        '${quranData[index]['end']['verse']} Verses',
                                        style: const TextStyle(color: trailingColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Row(
                              //   children: const [
                              //     Text(
                              //       "Juz’ 3",
                              //       style: TextStyle(color: Colors.black, fontSize: 14),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                              //   child: Column(
                              //     children: const [
                              //       ListTile(
                              //         title: Text(
                              //           'سُّورَةُ الفَاتِحَة',
                              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              //         ),
                              //         subtitle: Text('Surah Al-Fatiha'),
                              //         trailing: Text(
                              //           'Makki - 7 Verses',
                              //           style: TextStyle(color: trailingColor),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              // Row(
                              //   children: const [
                              //     Text(
                              //       "Juz’ 4",
                              //       style: TextStyle(color: Colors.black, fontSize: 14),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                              //   child: Column(
                              //     children: const [
                              //       ListTile(
                              //         title: Text(
                              //           'سُّورَةُ الفَاتِحَة',
                              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              //         ),
                              //         subtitle: Text('Surah Al-Fatiha'),
                              //         trailing: Text(
                              //           'Makki - 7 Verses',
                              //           style: TextStyle(color: trailingColor),
                              //         ),
                              //       ),
                              //       Divider(
                              //         color: Colors.grey,
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           'سُّورَةُ الفَاتِحَة',
                              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              //         ),
                              //         subtitle: Text('Surah Al-Fatiha'),
                              //         trailing: Text(
                              //           'Makki - 7 Verses',
                              //           style: TextStyle(color: trailingColor),
                              //         ),
                              //       ),
                              //       Divider(
                              //         color: Colors.grey,
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           'سُّورَةُ الفَاتِحَة',
                              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              //         ),
                              //         subtitle: Text('Surah Al-Fatiha'),
                              //         trailing: Text(
                              //           'Makki - 7 Verses',
                              //           style: TextStyle(color: trailingColor),
                              //         ),
                              //       ),
                              //       Divider(
                              //         color: Colors.grey,
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           'سُّورَةُ الفَاتِحَة',
                              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              //         ),
                              //         subtitle: Text('Surah Al-Fatiha'),
                              //         trailing: Text(
                              //           'Makki - 7 Verses',
                              //           style: TextStyle(color: trailingColor),
                              //         ),
                              //       ),
                              //       Divider(
                              //         color: Colors.grey,
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           'سُّورَةُ الفَاتِحَة',
                              //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                              //         ),
                              //         subtitle: Text('Surah Al-Fatiha'),
                              //         trailing: Text(
                              //           'Makki - 7 Verses',
                              //           style: TextStyle(color: trailingColor),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else {
                      return Container();
                    }



                  }),
          ),
              ),
        ],
      ),
    );
  }
}
