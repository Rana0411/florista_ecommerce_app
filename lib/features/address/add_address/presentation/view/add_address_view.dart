import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/features/address/add_address/presentation/cubit/add_address_view_model.dart';
import 'package:florista_ecommerce_app/features/address/add_address/presentation/widgets/add_address_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final AddAddressViewModel viewModel = getIt.get<AddAddressViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddAddressViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<AddAddressViewModel, AddAddressState>(
        listenWhen: (previous, current) =>
            previous.addAddressState != current.addAddressState,
        listener: (context, state) {
          if (state.addAddressState.data != null &&
              state.addAddressState.errorMessage == null &&
              state.addAddressState.isLoading == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Address saved successfully!'),
                backgroundColor: AppColors.lightGreen,
              ),
            );
            Navigator.pop(context);
          }
          if (state.addAddressState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.addAddressState.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                'Address',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: AddAddressForm(
              viewModel: viewModel,
              isLoading: state.addAddressState.isLoading == true,
            ),
          );
        },
      ),
    );
  }
}
