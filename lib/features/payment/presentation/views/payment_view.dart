import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/views/payment_webview.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/date_time_helper.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/delivery_address_section.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/delivery_time_section.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/gift_section.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/order_summary_section.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/payment_method_section.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:florista_ecommerce_app/config/shared_models/addresses/address_entity.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/view_model/payment_cubit.dart';
import 'package:florista_ecommerce_app/features/payment/presentation/widgets/place_order_button.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

class PaymentView extends StatefulWidget {
  final double subTotal;
  final double deliveryFee;
  final List<AddressEntity> addresses;

  const PaymentView({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
    required this.addresses,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? _selectedAddressId;
  String _paymentMethod = 'cod';
  bool _isGift = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  late List<AddressEntity> _addresses;

  @override
  void initState() {
    super.initState();
    // Seed with passed-in addresses, or fake demo data if none provided.
    _addresses = widget.addresses.isNotEmpty
        ? List.of(widget.addresses)
        : [
            const AddressEntity(
              id: '1',
              label: 'Home',
              plusCode: '2XVP+XC',
              area: 'Sheikh Zayed',
              lat: '30.028056',
              long: '30.969444',
              phone: '01000000000',
            ),
            const AddressEntity(
              id: '2',
              label: 'Office',
              plusCode: '2XVP+XC',
              area: 'Sheikh Zayed',
              lat: '30.028056',
              long: '30.969444',
              phone: '01000000000',
            ),
          ];

    if (_addresses.isNotEmpty) {
      _selectedAddressId = _addresses.first.id;
    }
  }

  @override
  void didUpdateWidget(covariant PaymentView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If a real address list arrives later (e.g. from an API call),
    // adopt it and auto-select the first one if nothing is selected yet.
    if (widget.addresses.isNotEmpty &&
        !_listEquals(widget.addresses, oldWidget.addresses)) {
      setState(() {
        _addresses = List.of(widget.addresses);
        if (_selectedAddressId == null ||
            !_addresses.any((a) => a.id == _selectedAddressId)) {
          _selectedAddressId = _addresses.first.id;
        }
      });
    }
  }

  bool _listEquals(List<AddressEntity> a, List<AddressEntity> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * 0.04).clamp(12.0, 24.0);

    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) async {
        final checkout = state.checkoutState;

        if (checkout.data != null && checkout.errorMessage == null) {
          final result = await Navigator.push<PaymentResult>(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  PaymentWebView(checkoutUrl: checkout.data!.checkoutUrl),
            ),
          );

          if (!context.mounted) return;
          context.read<PaymentCubit>().reset();

          switch (result) {
            case PaymentResult.success:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful!')),
              );
              Navigator.of(context).pop(true);
            case PaymentResult.cancelled:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment cancelled')),
              );
            case PaymentResult.failed:
            case null:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment was not completed')),
              );
          }
        } else if (checkout.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(checkout.errorMessage!)));
        }
      },
      builder: (context, state) {
        final loading = state.checkoutState.isLoading ?? false;

        return Scaffold(
          backgroundColor: AppColors.veryLightGrey,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Checkout'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DeliveryTimeSection(
                    estimatedArrival: DeliveryTimeHelper.estimatedArrival(
                      deliveryDuration: const Duration(hours: 1),
                    ),
                    deliveryLabel: 'Instant',
                  ),
                  const SizedBox(height: 16),
                  DeliveryAddressSection(
                    addresses: _addresses,
                    selectedAddressId: _selectedAddressId,
                    onChanged: (id) => setState(() => _selectedAddressId = id),
                    onEditAddress: _onEditAddress,
                    onAddAddress: _onAddAddress,
                  ),
                  const SizedBox(height: 16),
                  PaymentMethodSection(
                    selectedMethod: _paymentMethod,
                    onChanged: (v) => setState(() {
                      _paymentMethod = v!;
                      if (_paymentMethod == 'cod') {
                        _isGift = false;
                      }
                    }),
                  ),
                  const SizedBox(height: 16),
                  GiftSection(
                    isGift: _isGift,
                    enabled: _paymentMethod != 'cod',
                    onChanged: (v) => setState(() => _isGift = v),
                    nameController: _nameController,
                    phoneController: _phoneController,
                  ),
                  const SizedBox(height: 16),
                  OrderSummarySection(
                    subTotal: widget.subTotal,
                    deliveryFee: widget.deliveryFee,
                  ),
                  const SizedBox(height: 24),
                  PlaceOrderButton(
                    loading: loading,
                    enabled: _selectedAddressId != null,
                    onPressed: _onPlaceOrder,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onEditAddress(AddressEntity address) async {
    final result = await _showAddressDialog(initial: address);
    if (result == null) return;

    setState(() {
      final index = _addresses.indexWhere((a) => a.id == address.id);
      if (index != -1) _addresses[index] = result;
    });
  }

  Future<void> _onAddAddress() async {
    final result = await _showAddressDialog();
    if (result == null) return;

    setState(() {
      _addresses.add(result);
      _selectedAddressId = result.id;
    });
  }

  Future<AddressEntity?> _showAddressDialog({AddressEntity? initial}) {
    final labelController = TextEditingController(text: initial?.label ?? '');
    final plusCodeController = TextEditingController(
      text: initial?.plusCode ?? '',
    );
    final areaController = TextEditingController(text: initial?.area ?? '');
    final phoneController = TextEditingController(text: initial?.phone ?? '');

    return showDialog<AddressEntity>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(initial == null ? 'Add address' : 'Edit address'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: labelController,
                  decoration: const InputDecoration(
                    labelText: 'Label (e.g. Home)',
                  ),
                ),
                TextField(
                  controller: plusCodeController,
                  decoration: const InputDecoration(labelText: 'Plus code'),
                ),
                TextField(
                  controller: areaController,
                  decoration: const InputDecoration(labelText: 'Area'),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (labelController.text.trim().isEmpty ||
                    plusCodeController.text.trim().isEmpty ||
                    areaController.text.trim().isEmpty) {
                  return;
                }

                final result = AddressEntity(
                  id:
                      initial?.id ??
                      DateTime.now().millisecondsSinceEpoch.toString(),
                  label: labelController.text.trim(),
                  plusCode: plusCodeController.text.trim(),
                  area: areaController.text.trim(),
                  lat: initial?.lat ?? '30.028056',
                  long: initial?.long ?? '30.969444',
                  phone: phoneController.text.trim(),
                );

                Navigator.pop(context, result);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _onPlaceOrder() {
    if (_selectedAddressId == null) return;

    final selected = _addresses.firstWhere((a) => a.id == _selectedAddressId);
    if (_paymentMethod == 'cod') {
      context.go(RoutePath.orderSuccess, extra: selected.id);
    }

    context.read<PaymentCubit>().checkout(
      address: selected,
      paymentMethod: _paymentMethod,
    );
  }
}
