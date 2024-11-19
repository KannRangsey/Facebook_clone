// lib/permission_helper.dart

import 'package:permission_handler/permission_handler.dart';

Future<void> checkPhotoPermission() async {
  // Check if the permission is granted or denied
  var status = await Permission.photos.status;

  if (status.isDenied) {
    // Request permission if it's denied
    PermissionStatus newStatus = await Permission.photos.request();

    if (newStatus.isGranted) {
      // Permission granted, proceed to access photos
      print("Photo permission granted.");
    } else if (newStatus.isPermanentlyDenied) {
      // If permission is permanently denied, open app settings
      print("Photo permission permanently denied. Opening app settings.");
      openAppSettings();
    } else {
      // Permission denied
      print("Photo permission denied.");
    }
  } else if (status.isPermanentlyDenied) {
    // If permission is permanently denied, open app settings
    print("Photo permission permanently denied. Opening app settings.");
    openAppSettings();
  } else if (status.isGranted) {
    // Permission already granted
    print("Photo permission already granted.");
  }
}
