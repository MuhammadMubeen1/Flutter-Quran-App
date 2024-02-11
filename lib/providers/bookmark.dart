import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/providers/quran.dart';
import '../consolePrintWithColor.dart';
import '../core/custom_toast.dart';
import '../core/index.dart';
import '../models/bookmark_model.dart';

class BookMarkProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  List<BookMarkModel> bookMarks=[];
  String selectedItem='Arabic';
  int scrollIndex=0;
  updateScrollIndex(int index){
    printLog("======> Scroll index=$index");
    scrollIndex=index;
    notifyListeners();
  }

  updateSelectedItem(String value){
    selectedItem=value;
    notifyListeners();
  }

  String bookMarksKey="BookMarks";
  List<String> bookMarkKeys=[];
  late int currentPage;

  late int markPage;


  setBookMark(BuildContext context)async{
    // bookMarks.clear();
    //printLog("Setting bookMark");
    var quran=Provider.of<QuranProvider>(context,listen: false);
    bookMarkKeys=prefs.getStringList(bookMarksKey)??[];
    for(int i=0;i<bookMarkKeys.length;i++){
      printLog(bookMarkKeys[i]);
    }
    printLog(quran.currentPage.toString());
    if(bookMarkKeys.contains(quran.currentPage.toString()+quran.surahName)){

       CustomToast.show(context, "Bookmark Already Saved!");

     

    }else{
      BookMarkModel bookMarkModel=BookMarkModel(pageNumber: quran.currentPage, surahName: quran.surahName, status: "Quran");
      bookMarkKeys.add(quran.currentPage.toString()+quran.surahName);
      await prefs.setStringList(bookMarksKey, bookMarkKeys);
      await prefs.setString(quran.currentPage.toString()+quran.surahName,jsonEncode(bookMarkModel.toMap()) );
    // bookMarkToast();
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bookmark Added")));
     CustomToast.show(context, "Bookmark Saved!");


      notifyListeners();
    }

  }
  setBookMarkForLanguage(BuildContext context, int page , String language )async{
     bookMarks.clear();
    printLog("Setting bookMark");
    bookMarkKeys=await prefs.getStringList(bookMarksKey)??[];

    for(int i=0;i<bookMarkKeys.length;i++){
      printLog(bookMarkKeys[i]);
    }
    BookMarkModel bookMarkModel=BookMarkModel(pageNumber: page, surahName: language, status: "language" );
    if(bookMarkKeys.contains(page.toString()+language)){

      CustomToast.show(context, "Bookmark Already exists!");
    }else{
      bookMarkKeys.add(page.toString()+language);
      await prefs.setStringList(bookMarksKey, bookMarkKeys);
      await prefs.setString(page.toString()+language,jsonEncode(bookMarkModel.toMap()) );
      // bookMarkToast();
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bookmark Added")));
      CustomToast.show(context, "Bookmark Saved!");


    }

      notifyListeners();

  }

  deleteBookMark(BuildContext context,BookMarkModel bookMark)async{
    // bookMarks.clear();
    printLog("Deleting bookMark");
    var quran=Provider.of<QuranProvider>(context,listen: false);
    bookMarkKeys=prefs.getStringList(bookMarksKey)??[];
    printLog("=====>BookMarkKeys: ${bookMark.pageNumber}");
    bookMarkKeys.remove(bookMark.pageNumber.toString()+bookMark.surahName);
    printLog("=====>BookMarkKeys: ${bookMarkKeys.length}");
    await prefs.setStringList(bookMarksKey, bookMarkKeys);
    await prefs.remove(bookMark.pageNumber.toString()+bookMark.surahName);
     CustomToast.show(context, "Bookmark deleted!");
    
    notifyListeners();
  }

  getBookMarks(BuildContext context)async{
    bookMarks.clear();
    var quran=Provider.of<QuranProvider>(context,listen: false);
    List<String>? bookMarksList=prefs.getStringList(bookMarksKey)??[];
    if(bookMarksList.isNotEmpty){
      for(int i=0;i<bookMarksList.length;i++){
        String? value= prefs.get(bookMarksList[i]).toString()??"";
        if(value.isNotEmpty){
          var data=jsonDecode(value);

          printLog(data.toString());
          if(data!=null){
            bookMarks.add(BookMarkModel.fromJson(data));
          }

        }

      }
    }
    notifyListeners();

  }

  BookMarkProvider(this.prefs){
    markPage = prefs.getInt('mark') ?? 0;

  }

  void update(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  bool get isMarkedPage => currentPage == markPage;

  String get markButtonText {
    return isMarkedPage ? AppConstant.saved : AppConstant.saveBookmark;
  }

  Color get markButtonColor {
    return isMarkedPage
        ? const Color.fromARGB(255, 28, 95, 63)
        : Colors.transparent;
  }

  void changeMark() {
    markPage = currentPage;
    notifyListeners();
    prefs.setInt('mark', currentPage);
  }
  bookMarkToast() {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text("Bookmark Saved"),
        ],
        ),
    );}
}
