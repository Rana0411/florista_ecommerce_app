import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/screens/reset_password_view.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/widgets/validation_code_form.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidationCodeView extends StatefulWidget {
  const ValidationCodeView({super.key});

  @override
  State<ValidationCodeView> createState() => _ValidationCodeViewState();
}

class _ValidationCodeViewState extends State<ValidationCodeView> {
  final _pinController = TextEditingController();
  final viewModel = getIt.get<ForgetPasswordViewModel>();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
        listenWhen: (previous, current) =>
            previous.confirmValidationState != current.confirmValidationState,
        listener: (context, state) {
          if (state.confirmValidationState.data != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordView(),
              ),
            );
          } else if (state.confirmValidationState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.confirmValidationState.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(
              S.of(context).password,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  S.of(context).emailVerification,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 15),
                Text(
                  S.of(context).codeVerificationDis,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 40),
                BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.confirmValidationState.isLoading !=
                      current.confirmValidationState.isLoading,
                  builder: (context, state) {
                    return Column(
                      children: [
                        ValidationCodeForm(
                          controller: _pinController,
                          onCompleted: (pin) {
                            viewModel.confirmValidationCode(
                              body: {
                                ApiKeys.resetCode: pin,
                              },
                            );
                          },
                        ),
                        if (state.confirmValidationState.isLoading ?? false)
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).didNotReceiveCode,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.resendCode();
                      },
                      child: Text(
                        S.of(context).resend,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
