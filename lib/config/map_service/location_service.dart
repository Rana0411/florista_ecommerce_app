import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@lazySingleton
class LocationService {
  Future<BaseResponse<LatLng>> getCurrentLocation() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return ErrorBaseResponse<LatLng>(error: 'Service disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return ErrorBaseResponse<LatLng>(error: 'Permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return ErrorBaseResponse<LatLng>(error: 'Permission denied forever');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return SuccessBaseResponse<LatLng>(
        data: LatLng(position.latitude, position.longitude),
      );
    } catch (error) {
      return ErrorBaseResponse<LatLng>(error: error);
    }
  }
}
