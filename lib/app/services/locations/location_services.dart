import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<bool> requestPermission();
  Future<bool> checkPermission();
  Future<Position?> getCurrentLocation();
  Future<bool> hasPermission();
  Future<Map<String, dynamic>?> getCurrentCity(Position? position);
}

class LocationServiceImpl implements LocationService {
  @override
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    bool permissionGranted = await requestPermission();
    if (!permissionGranted) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> hasPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<Map<String, dynamic>?> getCurrentCity(Position? position) async {
    if (position != null) {
      final reverseRequest = ReverseRequest(
        lat: position.latitude,
        lon: position.longitude,
        addressDetails: true,
        extraTags: true,
        nameDetails: true,
      );
      final reverseResult = await NominatimFlutter.instance.reverse(
        reverseRequest: reverseRequest,
        language: 'en-US,en;q=0.5', // Specify the desired language(s) here
      );

      return reverseResult.address;
    }
    return null;
  }

  @override
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }
}
