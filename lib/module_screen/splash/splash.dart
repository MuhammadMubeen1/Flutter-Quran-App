import 'package:flutter/material.dart';

import '../../navbar/nav_bar.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8), // Total duration of 8 seconds (3 seconds + 5 seconds)
    );

    _logoFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.429), // 0.0 to 0.375 covers the first 3 seconds
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.429, 1.0), // 0.375 to 1.0 covers the remaining 5 seconds
    );

    _controller.forward();

    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 7)); // Wait for 8 seconds

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Opening2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(height: 18)),
            FadeTransition(
              opacity: _logoFadeAnimation,
              child: Image.asset(
                'assets/images/logo.png', // Your asset image path
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: _textFadeAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [



Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "“Those people who show no mercy,",
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  "will receive no mercy from Allah.”",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                   
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
    




                  // Center(
                  //   child: const Text(
                  //     "“Those people who show no mercy,will receive no mercy from Allah”",
                  //     style: TextStyle(fontSize: 16, color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            FadeTransition(
              opacity: _textFadeAnimation,
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "[Muslim, Al Fada’il; 66]",
                    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),


            SizedBox(height: 150,)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

