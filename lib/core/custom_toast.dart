import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomToast {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 550, // Adjust the top spacing
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6)
                    ]),
                width: 100,
                
                padding: EdgeInsets.symmetric(horizontal:16 ),
                child: Column(
                  children: [
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        //Lottie.asset('assets/images/bookmark.png',width: 24, height: 50, animate: true),
                       Image.asset('assets/images/bookmark.png', width: 30, height: 30, color: Color(0xffE4B452),fit: BoxFit.cover,),
                        SizedBox(width: 20),
                        Center(
                          child: Text(
                            message,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context)!.insert(overlayEntry);

    // Remove the toast after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

// To show the custom toast message:

