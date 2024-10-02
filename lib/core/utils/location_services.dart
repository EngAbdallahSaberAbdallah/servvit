//
// import 'package:location/location.dart' as loc;
//
// class LocationServices{
//
//   static loc.Location location = loc.Location();
//   static loc.LocationData? currentPosition;
//   static getCurrentLocation() async {
//     bool serviceEnabled;
//     loc.PermissionStatus permissionGranted;
//
//     serviceEnabled = await location.serviceEnabled();
//
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == loc.PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != loc.PermissionStatus.granted) {
//         return;
//       }
//     }
//     if (permissionGranted == loc.PermissionStatus.granted) {
//       location.changeSettings(accuracy: loc.LocationAccuracy.high);
//       currentPosition = await location.getLocation();
//     }
//   }
// }