// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GeolocatorService {
//   Future<String> getCurrentLocation() async {
//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           throw Exception('Location permissions denied.');
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         throw Exception('Location permissions permanently denied.');
//       }
//
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       Placemark place = placemarks[0];
//       return "${place.street}, ${place.administrativeArea}, ${place.country}";
//     } catch (e) {
//       throw Exception('Error getting location: $e');
//     }
//   }
// }
