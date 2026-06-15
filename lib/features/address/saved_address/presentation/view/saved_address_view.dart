import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/address_entity.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit/saved_address_event.dart';
import '../view_model/cubit/saved_address_view_model.dart';
import '../widgets/add_new_address_button.dart';
import '../widgets/address_card.dart';

class SavedAddressView extends StatelessWidget {
  const SavedAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 20,
        title: Text(S.current.savedAddress),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<SavedAddressViewModel, SavedAddressState>(
                  buildWhen: (prev, curr) =>
                      prev.getSavedAddressesState !=
                      curr.getSavedAddressesState,
                  builder: (context, state) {
                    final addressesState = state.getSavedAddressesState;

                    if (addressesState.isLoading == true) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (addressesState.errorMessage != null) {
                      return Center(
                        child: Text(
                          addressesState.errorMessage!,
                          style: TextStyle(
                            fontFamily: AppFonts.interFamily,
                            fontSize: FontSize.s14,
                            color: AppColors.error,
                          ),
                        ),
                      );
                    }

                    final addresses = addressesState.data ?? [];

                    if (addresses.isEmpty) {
                      return Center(
                        child: Text(
                          "no saved addresses",
                          style: TextStyle(
                            fontFamily: AppFonts.interFamily,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: addresses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return AddressCard(
                          address: address,
                          onDelete: () =>
                              _onDeletePressed(context, address: address),
                          onEdit: () {},
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              AddNewAddressButton(onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeletePressed(BuildContext context, {required AddressEntity address}) {
    final viewModel = context.read<SavedAddressViewModel>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("delete address"),
        content: Text("delete address confirmation"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              viewModel.doEvent(
                DeleteAddressEvent(addressId: address.id ?? ''),
              );
              Navigator.pop(dialogContext);
            },
            child: Text(
              "delete",
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
