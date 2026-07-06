import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/address/add_address/presentation/cubit/add_address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:geocoding/geocoding.dart';

import '../../data/data_sources/location_loader.dart';
import '../../data/data_sources/picked_location.dart';
import '../view/map_picker_view.dart';

class AddAddressForm extends StatefulWidget {
  final AddAddressViewModel viewModel;
  final bool isLoading;

  const AddAddressForm({
    super.key,
    required this.viewModel,
    required this.isLoading,
  });

  @override
  State<AddAddressForm> createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _recipientNameController = TextEditingController();

  bool _isLoadingLocations = true;

  GovernorateModel? _selectedGovernorate;
  CityModel? _selectedCity;
  List<CityModel> _currentCities = [];

  // Map state
  final MapController _mapController = MapController();
  ll.LatLng _selectedLatLng = const ll.LatLng(30.0444, 31.2357); // Cairo default
  bool _isResolvingAddress = false;

  @override
  void initState() {
    super.initState();
    _initLocations();
  }

  Future<void> _initLocations() async {
    await LocationDataLoader.load();
    final governorates = LocationDataLoader.governorates;

    setState(() {
      _selectedGovernorate = governorates.isNotEmpty ? governorates.first : null;
      _currentCities = _selectedGovernorate != null
          ? LocationDataLoader.citiesFor(_selectedGovernorate!.id)
          : [];
      _selectedCity = _currentCities.isNotEmpty ? _currentCities.first : null;
      _isLoadingLocations = false;
    });
  }

  // Way 1: user drags the small inline map (no click)
  Future<void> _onMapIdle() async {
    setState(() => _isResolvingAddress = true);
    try {
      final placemarks = await placemarkFromCoordinates(
        _selectedLatLng.latitude,
        _selectedLatLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          p.street,
          p.subLocality,
          p.locality,
        ].where((e) => e != null && e.isNotEmpty).toList();
        if (parts.isNotEmpty) {
          setState(() {
            _addressController.text = parts.join(', ');
          });
        }
      }
    } catch (_) {
      // ignore, user can type manually
    } finally {
      setState(() => _isResolvingAddress = false);
    }
  }

  // Way 2: open full-screen map picker
  Future<void> _openMapPicker() async {
    final result = await Navigator.push<PickedLocation>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerView(initialLocation: _selectedLatLng),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedLatLng = ll.LatLng(result.latitude, result.longitude);
        _addressController.text = result.address;
      });
      _mapController.move(_selectedLatLng, 15);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _recipientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingLocations) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Map section
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _selectedLatLng,
                    initialZoom: 15,
                    onPositionChanged: (position, hasGesture) {
                      if (hasGesture) {
                        _selectedLatLng = position.center!;
                      }
                    },
                    onTap: (tapPosition, point) => _openMapPicker(),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                      'com.florista.florista_ecommerce_app',
                    ),
                  ],
                ),

                // Fixed center pin
                 Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Icon(
                    Icons.location_pin,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),

                // Loading indicator while resolving address
                if (_isResolvingAddress)
                  const Positioned(
                    top: 12,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),

                // "Open map" button
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _openMapPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.fullscreen,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            'Open map',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address field
                  _buildLabeledTextField(
                    context: context,
                    label: 'Address',
                    hint: 'Enter the address',
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Phone number field
                  _buildLabeledTextField(
                    context: context,
                    label: 'Phone number',
                    hint: 'Enter the phone number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a phone number';
                      }
                      if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value.trim())) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Recipient name field
                  _buildLabeledTextField(
                    context: context,
                    label: 'Recipient name',
                    hint: 'Enter the recipient name',
                    controller: _recipientNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the recipient name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Governorate & City dropdowns
                  Row(
                    children: [
                      // Governorate dropdown
                      Expanded(
                        child: _buildGovernorateDropdown(context),
                      ),
                      const SizedBox(width: 12),
                      // City dropdown
                      Expanded(
                        child: _buildCityDropdown(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Save address button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.isLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          widget.viewModel.addAddress(
                            street: _addressController.text.trim(),
                            phone: _phoneController.text.trim(),
                            city:
                            '${_selectedGovernorate?.nameEn} - ${_selectedCity?.nameEn}',
                            lat: _selectedLatLng.latitude.toString(),
                            long: _selectedLatLng.longitude.toString(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightGrey,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: widget.isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                          : Text(
                        'Save address',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGovernorateDropdown(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hintColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hintColor),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<GovernorateModel>(
          value: _selectedGovernorate,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
          items: LocationDataLoader.governorates
              .map(
                (gov) => DropdownMenuItem<GovernorateModel>(
              value: gov,
              child: Text(
                gov.nameEn,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.hintColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
              .toList(),
          onChanged: (gov) {
            if (gov == null) return;
            setState(() {
              _selectedGovernorate = gov;
              _currentCities = LocationDataLoader.citiesFor(gov.id);
              _selectedCity =
              _currentCities.isNotEmpty ? _currentCities.first : null;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCityDropdown(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Area',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hintColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hintColor),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CityModel>(
          value: _selectedCity,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
          items: _currentCities
              .map(
                (city) => DropdownMenuItem<CityModel>(
              value: city,
              child: Text(
                city.nameEn,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.hintColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
              .toList(),
          onChanged: (city) {
            if (city == null) return;
            setState(() => _selectedCity = city);
          },
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.hintColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hintColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.hintColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}