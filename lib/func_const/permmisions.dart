import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

var stat = false;

Future<bool> checkPermission(BuildContext context) async {

  final androidInfo = await DeviceInfoPlugin().androidInfo;
  var sdk = androidInfo.version.sdkInt;
  late final Map<Permission, PermissionStatus> statuses;
  if (sdk! >= 33) {
    statuses = await [
      Permission.manageExternalStorage,
      Permission.photos
    ].request();
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


