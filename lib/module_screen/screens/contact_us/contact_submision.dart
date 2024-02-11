import 'package:flutter/material.dart';
import 'package:untitled/module_screen/screens/contact_us/contact_us.dart';

import '../../../core/app_color.dart';
class ContactSubmition extends StatefulWidget {
  const ContactSubmition({Key? key}) : super(key: key);

  @override
  State<ContactSubmition> createState() => _ContactSubmitionState();
}

class _ContactSubmitionState extends State<ContactSubmition>  with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;
  bool isAnumation = true;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6), // Total duration of 8 seconds (3 seconds + 5 seconds)
    );

    _logoFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.425), // 0.0 to 0.375 covers the first 3 seconds
    );



    _controller.forward();
    _navigateToHome();


  }
  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 8 seconds

   setState(() {
     isAnumation = false;
   });

    _textFadeAnimation = CurvedAnimation(

      parent: _controller,
      curve: Interval(0.229, 1.0), // 0.375 to 1.0 covers the remaining 5 seconds
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Contact",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: isAnumation ? Center(
          child: FadeTransition(
            opacity: _logoFadeAnimation,
            child:     Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/tick.gif', height: 200,width: 200,fit: BoxFit.cover,),

              ],
            ),
          ),
        ):
        //
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              Image.asset('assets/images/image 3.png',),
              FadeTransition(
                opacity: _textFadeAnimation,
                child:      Column(children: [

                  //SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text("Thank you for reaching out", style: TextStyle(fontSize: 30, ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text("We have received your message and will get back to you as soon as possible", style: TextStyle(fontSize: 14, ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  MaterialButton(
                    color: iconColors,
                    height: 50,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUs()));
                    },
                    child: const Text('Submit Another Request'),
                  ),
                  const SizedBox(height: 25.0)

                ],),



              ),

            ],
          ),


        ),
        
      ),
    );
  }
}
