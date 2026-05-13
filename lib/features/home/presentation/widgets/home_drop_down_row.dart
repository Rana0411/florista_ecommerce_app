import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_event.dart';
import 'package:florista_ecommerce_app/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDropDownRow extends StatefulWidget {
  const HomeDropDownRow({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<HomeDropDownRow> createState() => _HomeDropDownRowState();
}

class _HomeDropDownRowState extends State<HomeDropDownRow> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      buildWhen: (previous, current) =>
          previous.getLoggedUserAddressesState !=
              current.getLoggedUserAddressesState ||
          previous.selectedAddressId != current.selectedAddressId,
      builder: (context, state) {
        final addresses = state.getLoggedUserAddressesState.data;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.place_outlined, color: AppColors.grey, size: 22),

            const SizedBox(width: 6),

            DropdownButton<String>(
              value: state.selectedAddressId,
              items: addresses
                  ?.map(
                    (address) => DropdownMenuItem<String>(
                      value: address.id?.toString(),
                      child: Text(address.city ?? ''),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                if (value != null) {
                  widget.viewModel.doEvent(SelectAddressEvent(value: value));
                }
              },

              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              iconEnabledColor: AppColors.primary,
              iconDisabledColor: AppColors.lightGrey,
              underline: const SizedBox(),
              isDense: true,
            ),
          ],
        );
      },
    );
  }
}
