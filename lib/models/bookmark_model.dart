


import 'package:flutter/cupertino.dart';

class BookMarkModelFields{
  static const String pageNumber="pageNumber";
  static const String surahName="surahName";
  static const String status= "status";
}

class BookMarkModel{
  int pageNumber;
  String surahName;
  String status;


  BookMarkModel({
  required this.pageNumber,
    required this.surahName,
    required this.status,

});

  Map<String,dynamic> toMap()=>{
    BookMarkModelFields.pageNumber:pageNumber,
    BookMarkModelFields.surahName:surahName,
    BookMarkModelFields.status:status
  };

  factory BookMarkModel.fromJson(Map<String,dynamic> json)=>BookMarkModel(
    pageNumber:json[BookMarkModelFields.pageNumber],
    surahName:json[BookMarkModelFields.surahName],
      status: json[BookMarkModelFields.status]!=null?json[BookMarkModelFields.status]:"",
  );

}