import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';

import '../../data/data_sources/picked_location.dart';

class MapPickerView extends StatefulWidget {
  final ll.LatLng? initialLocation;

  const MapPickerView({super.key, this.initialLocation});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  final MapController _mapController = MapController();
  late ll.LatLng _selectedLatLng;
  String _address = 'Loading address...';
  bool _isLoadingAddress = true;

  @override
  void initState() {
    super.initState();
    _selectedLatLng =
        widget.initialLocation ?? const ll.LatLng(30.0444, 31.2357); // Cairo
    _resolveAddress(_selectedLatLng);
  }

  Future<void> _resolveAddress(ll.LatLng position) async {
    setState(() => _isLoadingAddress = true);
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          p.street,
          p.subLocality,
          p.locality,
          p.administrativeArea,
        ].where((e) => e != null && e.isNotEmpty).toList();
        setState(() {
          _address = parts.isNotEmpty ? parts.join(', ') : 'Unknown location';
          _isLoadingAddress = false;
        });
      } else {
        setState(() {
          _address = 'Unknown location';
          _isLoadingAddress = false;
        });
      }
    } catch (_) {
      setState(() {
        _address = 'Unable to fetch address';
        _isLoadingAddress = false;
      });
    }
  }

  Future<void> _goToCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
        }
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      final latLng = ll.LatLng(position.latitude, position.longitude);
      _mapController.move(latLng, 15);
      setState(() => _selectedLatLng = latLng);
      _resolveAddress(latLng);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not get current location')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLatLng,
              initialZoom: 15,
              onTap: (tapPosition, point) {
                setState(() => _selectedLatLng = point);
                _resolveAddress(point);
              },
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  _selectedLatLng = position.center!;
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                'com.florista.florista_ecommerce_app', // غيّره لاسم باكدجك
              ),
            ],
          ),

          // Pin ثابت في النص
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Icon(
                Icons.location_pin,
                color: AppColors.primary,
                size: 48,
              ),
            ),
          ),

          // زرار "موقعي الحالي"
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton.small(
              backgroundColor: Colors.white,
              onPressed: _goToCurrentLocation,
              child: Icon(Icons.my_location, color: AppColors.primary),
            ),
          ),

          // كارت تأكيد العنوان في الأسفل
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected location',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    _isLoadingAddress
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Text(
                      _address,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoadingAddress
                            ? null
                            : () {
                          Navigator.pop(
                            context,
                            PickedLocation(
                              latitude: _selectedLatLng.latitude,
                              longitude: _selectedLatLng.longitude,
                              address: _address,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Confirm location'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}