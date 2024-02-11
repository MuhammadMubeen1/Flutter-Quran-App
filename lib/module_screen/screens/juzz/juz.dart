import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
 import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../core/app_color.dart';
import '../../../providers/bookmark.dart';
import '../../../providers/bottom_navigation_provider.dart';
import '../../../providers/quran.dart';
import '../../../providers/show_overlay_provider.dart';
import '../../../quran/quran.dart';
import '../../../screens/search_juzz.dart';
class JuzScreen extends StatefulWidget {
  final bool? navigateFromQuranIndex;
  const JuzScreen({this.navigateFromQuranIndex=false,Key? key}) : super(key: key);

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  List<dynamic> quranData = [];
  // List jsonData = [];
 // List<Map<String, dynamic>>  jsonData= [];
  ScrollController _controller = ScrollController();
  bool isLoading = true;
  // void getJuzData() async {

  //   try {
  //     var response =
  //     await http.get(Uri.parse('http://43.204.244.182/api/v1/juzs'));

  //     if (response.statusCode == 200) {
  //       var res = response.body;
  //       var body = jsonDecode(res);
  //       //   List<Map<String, dynamic>> quranData = body['data'];

  //       setState(() {
  //         quranData = body['data'];
  //       });
  //        print("quran data ${quranData}");
  //        setState(() {
  //          isLoading = false;
  //        });

  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // void _scrollListener() {
  //   if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
  //     if (_isKeyboardVisible) {
  //       FocusScope.of(context).unfocus();
  //     }
  //     _isKeyboardVisible = false;
  //   } else if (_controller.position.userScrollDirection == ScrollDirection.forward) {
  //     _isKeyboardVisible = true;
  //   }
  // }

  bool _isKeyboardVisible = false;

  @override
  // void initState() {
  //   getJuzData();
  //   _controller.addListener(_scrollListener);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _controller.removeListener(_scrollListener);
  //   super.dispose();
  // }
  // List to store JSON data

  @override
  void initState() {
    super.initState();
    readJson();
   // Load JSON data when the screen initializes
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


  bool isSearching = false;
  var verseList= [];
  var curentJuz;
  TextEditingController search =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<BottomNavigationProvider>(context, listen: false);
    final quran = Provider.of<QuranProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: isSearching ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child:TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              autofocus: true,
              controller: search,
              onChanged: (val) {
                setState(() {});
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Juz',
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ):
          const Text(
              "Juz",
            style: TextStyle(color: Colors.black),
          ),
          actions:  [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchJuzz()));

               
                // FocusScope.of(context).unfocus();
                // setState((){
                //   isSearching=!isSearching;
                // });
              },
              child: const  Icon(
                Icons.search,
                color: defaultColor,
                size: 28,
              ),
            ),

            const  SizedBox(
              width: 22,
            ),
          ],
        ),

      body:GestureDetector(

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
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(page - 1);
                      print("going");
                    });
                  } else if(surahNumber ==2){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(21);
                      print("going");
                    });
                  }else if(surahNumber ==3){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(41);
                      print("going");
                    });
                  }else if(surahNumber ==4){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(61);
                      print("going");
                    });
                  }
                  else if(surahNumber ==5){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(81);
                      print("going");
                    });
                  }   else if(surahNumber ==6){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(101);
                      print("going");
                    });
                  }
                  else if(surahNumber ==7){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(120);
                      print("going");
                    });
                  }
                  else if(surahNumber ==8){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(141);
                      print("going");
                    });
                  }
                  else if(surahNumber ==9){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(161);
                      print("going");
                    });
                  }
                  else if(surahNumber ==10){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(181);
                      print("going");
                    });
                  }
                  else if(surahNumber ==11){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(200);
                      print("going");
                    });
                  }
                  else if(surahNumber ==12){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(221);
                      print("going");
                    });
                  }
                  else if(surahNumber ==13){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(241);
                      print("going");
                    });
                  }
                  else if(surahNumber ==14){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(261);
                      print("going");
                    });
                  }
                  else if(surahNumber ==15){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(281);
                      print("going");
                    });
                  }
                  else if(surahNumber ==16){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(301);
                      print("going");
                    });
                  }
                  else if(surahNumber ==17){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(321);
                      print("going");
                    });
                  }
                  else if(surahNumber ==18){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(341);
                      print("going");
                    });
                  }
                  else if(surahNumber ==19){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(361);
                      print("going");
                    });
                  }
                  else if(surahNumber ==20){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(381);
                      print("going");
                    });
                  }
                  else if(surahNumber ==21){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(401);
                      print("going");
                    });
                  }
                  else if(surahNumber ==22){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(421);
                      print("going");
                    });
                  }
                  else if(surahNumber ==23){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(441);
                      print("going");
                    });
                  }
                  else if(surahNumber ==24){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(461);
                      print("going");
                    });
                  }
                  else if(surahNumber ==25){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(481);
                      print("going");
                    });
                  }
                  else if(surahNumber ==26){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(501);
                      print("going");
                    });
                  }
                  else if(surahNumber ==27){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(521);
                      print("going");
                    });
                  }
                  else if(surahNumber ==28){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(541);
                      print("going");
                    });
                  }
                  else if(surahNumber ==29){
                    await indexProvider.updateIndex(2);
                    print(page);
                    Future.delayed(const Duration(milliseconds: 300),(){
                      quran.goToPage(561);
                      print("going");
                    });
                  }
                  else if(surahNumber ==30){
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
      )

    );
  }
  // void _showSurahReadDialog(int startVerse , int endVerse, String FirstSurah, String endSurah, int startChapter, int endChapter ) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Read Surah"),
  //         content: Text("Do you want to read the Surah?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (context) =>ReadJuzz(startChapter, FirstSurah, )));
  //             },
  //             child: Text("${FirstSurah}"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (context) =>ReadJuzz(endChapter, endSurah, )));
  //             },
  //             child: Text("${endSurah}"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}
