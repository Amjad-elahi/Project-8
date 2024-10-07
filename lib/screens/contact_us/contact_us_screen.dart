import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/contact_item/contact_item.dart';
import 'package:onze_cofe_project/components/contact_item/contact_social.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw launchUrlString(
          "https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwjPi7qXuu-IAxXcSaQEHV2kKsoQPAgI");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromRGBO(192, 196, 171, 1)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Contact us',
            style: TextStyle(
              color: Color.fromRGBO(192, 196, 171, 1),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  title: Text(
                    'Customer Support',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(192, 196, 171, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                buildContactItem(
                  icon: Icons.phone,
                  label: 'Contact Number',
                  info: '0507843710',
                ),
                buildContactItem(
                  icon: Icons.email,
                  label: 'Contact Number',
                  info: 'Onza@gmail.com',
                ),
                const ListTile(
                  title:  Text(
                    'Social Media',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(192, 196, 171, 1),
                    ),
                  ),
                ),
                buildSocialMediaItem(
                  iconPath: 'assets/images/whatsapp.png',
                  label: '@Onze Cafe',
                  onTap: () => launchURL('https://wa.me/0507843710'),
                ),
                buildSocialMediaItem(
                  iconPath: 'assets/images/twitter.png',
                  label: '@Onze Cafe',
                  onTap: () => launchURL('https://twitter.com/OnzeCafe'),
                ),
                buildSocialMediaItem(
                  iconPath: 'assets/images/tiktok.png',
                  label: '@Onze Cafe',
                  onTap: () => launchURL('https://www.tiktok.com/@OnzeCafe'),
                ),
                buildSocialMediaItem(
                  iconPath: 'assets/images/snapchat.png',
                  label: '@Onze Cafe',
                  onTap: () =>
                      launchURL('https://www.snapchat.com/add/OnzeCafe'),
                ),
                buildSocialMediaItem(
                  iconPath: 'assets/images/instagram.png',
                  label: '@Onze Cafe',
                  onTap: () => launchURL('https://www.instagram.com/OnzeCafe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}