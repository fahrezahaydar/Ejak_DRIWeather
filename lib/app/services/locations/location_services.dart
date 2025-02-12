import 'package:location/location.dart';

abstract class LocationService {
  Future<bool> requestPermission();
  Future<LocationData?> getCurrentLocation();
  Future<bool> hasPermission();
}

class LocationServiceImpl implements LocationService {
  final Location _location = Location();

  @override
  Future<bool> requestPermission() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }
    return permission == PermissionStatus.granted;
  }

  @override
  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return null;
    }

    bool permissionGranted = await requestPermission();
    if (!permissionGranted) return null;

    return await _location.getLocation();
  }

  @override
  Future<bool> hasPermission() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
}
