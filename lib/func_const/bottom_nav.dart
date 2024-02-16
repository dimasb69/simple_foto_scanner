import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget bottomDevName() {
  return SizedBox(
    height: 20,
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () async{
                final Uri url = Uri.parse('https://momdontgo.dev');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const Text('Developed',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xA6111111),
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: ()async{
                final Uri url = Uri.parse('https://momdontgo.dev');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const Text(' By {MomDontGo.Dev}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xA6111111),
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
  );
}