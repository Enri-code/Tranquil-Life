import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> _handlePermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) return false;
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    return true;
  }

  static Future<String> _getAddressFromCords(Position position) async {
    final placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placeMarks[0];
    return '${place.subLocality}, ${place.subAdministrativeArea},';
  }

  static Future<Position?> requestPosition() async {
    try {
      if (!await _handlePermission()) return null;
      return Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  static Future<String?> requestLocation() async {
    final position = await requestPosition();
    if (position == null) return null;
    return _getAddressFromCords(position);
  }
}
