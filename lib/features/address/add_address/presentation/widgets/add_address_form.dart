import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/address/add_address/presentation/cubit/add_address_view_model.dart';
import 'package:flutter/material.dart';

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

  // Egypt cities list
  final List<String> _cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Sharm El-Sheikh',
    'Mansoura',
    'Tanta',
    'Zagazig',
  ];

  // Areas per city (simplified)
  final Map<String, List<String>> _areas = {
    'Cairo': ['Nasr City', 'Heliopolis', 'Maadi', 'Zamalek', 'October', 'New Cairo'],
    'Alexandria': ['Montazah', 'Smouha', 'Agami', 'Gleem'],
    'Giza': ['Dokki', 'Mohandessin', '6th October', 'Haram'],
    'Luxor': ['Luxor City', 'Karnak', 'West Bank'],
    'Aswan': ['Aswan City', 'Elephantine Island'],
    'Hurghada': ['Hurghada City', 'El Gouna', 'Sahl Hasheesh'],
    'Sharm El-Sheikh': ['Naama Bay', 'Hadaba', 'Sharm El Maya'],
    'Mansoura': ['Mansoura City', 'Talkha'],
    'Tanta': ['Tanta City', 'Basyoun'],
    'Zagazig': ['Zagazig City', 'Abu Hammad'],
  };

  String _selectedCity = 'Cairo';
  String _selectedArea = 'October';

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _recipientNameController.dispose();
    super.dispose();
  }

  List<String> get _currentAreas =>
      _areas[_selectedCity] ?? [_selectedCity];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Map section
          Container(
            height: 160,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/map_placeholder.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xffE8E8E8),
                    child: Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 60,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.location_pin,
                  color: AppColors.primary,
                  size: 40,
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

                  // City & Area dropdowns
                  Row(
                    children: [
                      // City dropdown
                      Expanded(
                        child: _buildLabeledDropdown(
                          context: context,
                          label: 'City',
                          value: _selectedCity,
                          items: _cities,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedCity = val;
                                _selectedArea =
                                    (_areas[val]?.isNotEmpty == true)
                                        ? _areas[val]!.first
                                        : val;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Area dropdown
                      Expanded(
                        child: _buildLabeledDropdown(
                          context: context,
                          label: 'Area',
                          value: _selectedArea,
                          items: _currentAreas,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedArea = val);
                            }
                          },
                        ),
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
                                  city: _selectedCity,
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

  Widget _buildLabeledDropdown({
    required BuildContext context,
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
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
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
