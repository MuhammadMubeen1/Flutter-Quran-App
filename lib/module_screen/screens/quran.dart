
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuranPage extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<Map<String, dynamic>> combinedVerses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    quranLine();
  }
  quranLine() async {
    var request = http.Request('GET', Uri.parse('http://43.204.244.182/api/v1/quran'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      String? currentChapter;
      List<String> chapterVerses = [];

      for (var verse in body["data"]) {
        if (currentChapter == null) {
          // Initialize the currentChapter with the first chapter value
          currentChapter = verse['chapter'];
        }

        if (verse['chapter'] != currentChapter) {
          combinedVerses.add({
            'chapter': currentChapter,
            'verses': chapterVerses.join(' '), // Combine the verses into a single string
          });

          currentChapter = verse['chapter'];
          chapterVerses = [];
        }
        chapterVerses.add('${verse['text']} ${verse['verse']}');
      }
      if (chapterVerses.isNotEmpty) {
        combinedVerses.add({
          'chapter': currentChapter,
          'verses': chapterVerses.join(' '), // Combine the verses into a single string
        });
      }

      setState(() {
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  List<InlineSpan> _parseTextWithImages(String text) {
    List<InlineSpan> spans = [];
    RegExp numericRegExp = RegExp(r'\b\d+\b'); // Regular expression to match numeric values

    var matches = numericRegExp.allMatches(text);

    int previousEnd = 0;

    for (var match in matches) {
      spans.add(TextSpan(text: text.substring(previousEnd, match.start)));

      int value = int.parse(match.group(0)!);

      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/juzzimage.png",
              width: 32, // Adjust the width as needed
              height: 32, // Adjust the height as needed
            ),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 12, // Adjust the font size as needed
                color: Colors.black,
                fontWeight: FontWeight.bold,

              ),
            ),
          ],
        ),
      ));

      previousEnd = match.end;
    }

    if (previousEnd < text.length) {
      spans.add(TextSpan(text: text.substring(previousEnd)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: combinedVerses.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              index == 0
                  ? Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 0),
                    height: 140,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Group 3.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 102),
                      child: Center(
                        child: Text(
                          '${combinedVerses[index]['chapter']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/goldenframe.png"),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Center(
                        child: Text(
                          '${combinedVerses[index]['chapter']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(

                  children: _parseTextWithImages(combinedVerses[index]['verses']),
                  style: TextStyle(

                    fontSize: 35,
                    height: 1.7,
                    color: Colors.black.withOpacity(0.6),
                  ),
                 // textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}











