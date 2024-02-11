import 'package:flutter/material.dart';

import '../../core/app_color.dart';
class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(children: [
          const SizedBox(height: 15,),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search, Verse..',
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20,),
          const Text("Try search with:", style: TextStyle(fontSize: 20),),
          const SizedBox(height: 10,),
          const Text("Surah Al-Fateha", style: TextStyle(fontSize: 17 , color: iconColors),),
          const SizedBox(height: 10,),
          const Text("سيقول السفهاء", style: TextStyle(fontSize: 17 , color: iconColors),),
          const SizedBox(height: 10,),
          const Text("Surah Al-Baqarah", style: TextStyle(fontSize: 17 , color: iconColors),),
          const SizedBox(height: 10,),
          const Text("سيقول السفهاء", style: TextStyle(fontSize: 17 , color: iconColors),),


        ],),
      ),
    );
  }
}
