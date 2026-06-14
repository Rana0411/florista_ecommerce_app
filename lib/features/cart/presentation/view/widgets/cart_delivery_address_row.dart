import 'package:florista_ecommerce_app/core/constants/static_delivery_address.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/core/utils/maps_launcher.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/address_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';

class CartDeliveryAddressRow extends StatelessWidget {
  const CartDeliveryAddressRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: InkWell(
        onTap: () => _showAddressSheet(context),
        onLongPress: () => _openMaps(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      color: AppColors.grey,
                    ),
                    children: [
                      TextSpan(text: S.of(context).deliverTo),
                      TextSpan(
                        text: StaticDeliveryAddress.shortLine,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMaps(BuildContext context) async {
    final opened = await MapsLauncher.openDeliveryAddress();
    if (!context.mounted || opened) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).couldNotOpenMaps)));
  }

  Future<void> _showAddressSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).deliveryAddress,
                  style: TextStyle(
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                AddressDetailTile(
                  icon: Icons.home_outlined,
                  title: StaticDeliveryAddress.label,
                  subtitle: StaticDeliveryAddress.fullAddress,
                ),
                const SizedBox(height: 12),
                AddressDetailTile(
                  icon: Icons.pin_drop_outlined,
                  title: S.of(context).plusCode,
                  subtitle: StaticDeliveryAddress.plusCode,
                ),
                const SizedBox(height: 12),
                AddressDetailTile(
                  icon: Icons.map_outlined,
                  title: S.of(context).area,
                  subtitle:
                      '${StaticDeliveryAddress.area}, ${StaticDeliveryAddress.governorate}',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(sheetContext).pop();
                      await _openMaps(context);
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: Text(S.of(context).openInMaps),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(
                    S.of(context).close,
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
