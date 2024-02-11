import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:open_store/open_store.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/app_color.dart';
import 'contact_us/contact_us.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                child: Column(
                  children:  [
                    ListTile(
                        onTap: () {
                          AppSettings.openAppSettings(type: AppSettingsType.notification);
                          print("click");
                        },
                        leading: const Icon(
                          Icons.notification_add_outlined,
                          color: Colors.black,
                        ),
                        title: const Text(
                          'Turn on notifications',
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: trailingColor,
                          size: 20,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              
             
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                child: Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Share.share('Check out The Quran - القرآن الكريم', subject: 'Look what I made!');
                        },
                        leading: const Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        title: const Text(
                          'Share the app',
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: trailingColor,
                          size: 20,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                child: Column(
                  children: [
                    ListTile(
                        onTap: () {
                          OpenStore.instance.open(
                              appStoreId: '284815942', // AppStore id of your app for iOS
                              appStoreIdMacOS: '284815942', // AppStore id of your app for MacOS (appStoreId used as default)
                              androidAppBundleId: 'com.google.android.googlequicksearchbox', // Android app bundle package name
                              windowsProductId: '9NZTWSQNTD0S' // Microsoft store id for Widnows apps
                          );
                        },
                        leading: const Icon(
                          Icons.star_outline,
                          color: Colors.black,
                        ),
                        title: const Text(
                          'Write a review',
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: trailingColor,
                          size: 20,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                child: Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUs()));
                        },
                        leading: const Icon(
                          Icons.contact_page_outlined,
                          color: Colors.black,
                        ),
                        title: const Text(
                          'Contact us',
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: trailingColor,
                          size: 20,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
                child:  Column(
                  children:  [
                    ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Colors.black,
                      ),
                      title: Text(
                        'App Version',
                        style: TextStyle(fontSize: 13),
                      ),
                      trailing: Text(
                        '1.0',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
