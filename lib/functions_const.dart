import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';




import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

var stat = false;

Future<bool> checkPermission(BuildContext context) async {

  final androidInfo = await DeviceInfoPlugin().androidInfo;
  var sdk = androidInfo.version.sdkInt.toString();
  late final Map<Permission, PermissionStatus> statuses;
  if (sdk == "33" || sdk == "34") {
    statuses = await [Permission.manageExternalStorage, Permission.photos].request();
  } else {
    statuses = await [
      Permission.manageExternalStorage,
      Permission.storage
    ].request();
  }

  var stat = false;
  statuses.forEach((permission, status) {
    //print(status);
    if (status != PermissionStatus.granted) {
      stat = false;
    } else {
      stat = true;
    }
  });
  return stat;
}

var perm10 = 0;

Future<void> checkWritePermission() async {
  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      var permissionStatus = await Permission.storage.status;

      print('permission status: $permissionStatus');

      switch (permissionStatus) {
        case PermissionStatus.denied:
          await Permission.storage.request();
          if (await Permission.storage.status == PermissionStatus.granted){
            perm10 = 1;
          }
          break;
        case PermissionStatus.permanentlyDenied:
          await Permission.storage.request();
          if (await Permission.storage.status == PermissionStatus.granted){
            perm10 = 1;
          }
          break;
        default:
      }
    }
  }
}

Future<bool> _checkPermission(BuildContext context) async {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  var sdk = androidInfo.version.sdkInt.toString();

  late final Map<Permission, PermissionStatus> statusess;

  if (sdk == "33") {
    statusess =
    await [Permission.manageExternalStorage, Permission.photos, Permission.storage].request();
  } else {
    statusess = await [
      Permission.manageExternalStorage,
      Permission.storage
    ].request();
  }

  var stat = false;
  statusess.forEach((permission, status) {
    if (status != PermissionStatus.granted) {
      stat = false;
    } else {
      stat = true;
    }
  });
  return stat;
}

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
