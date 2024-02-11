import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import 'contact_submision.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    message.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside of text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon( Icons.arrow_back_ios_new_outlined,)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Contact",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      controller: name,
                      validator: (value) =>
                      value!.isEmpty ? 'Name cannot be blank' : null,
                      decoration:  InputDecoration(
                        hintText: "Enter your name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: defaultColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: defaultColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
                          borderSide: BorderSide(
                              width: 1, color: Colors.redAccent),
                        ),

                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email cannot be blank';
                        } else if (!_isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        hintText: "Enter your email address",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: defaultColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: defaultColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
                          borderSide: BorderSide(
                              width: 1, color: Colors.redAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: message,
                      validator: (value) =>
                      value!.isEmpty ? 'Message cannot be blank' : null,
                      maxLines: 4,
                      decoration:  InputDecoration(
                        hintText: "Message",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: defaultColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: defaultColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),//<-- SEE HERE
                          borderSide: BorderSide(
                              width: 1, color: Colors.redAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 95.0),
                    MaterialButton(
                      color: iconColors,
                      height: 50,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSubmition()));
                        }
                      },
                      child: const Text('Submit Request'),
                    ),
                    const SizedBox(height: 25.0)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
