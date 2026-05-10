import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/core/app_keys/api_keys.dart';
import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/features/auth/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  ForgetPasswordViewModel viewModel = getIt.get<ForgetPasswordViewModel>();


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordViewModel>(
      create: (context) => viewModel,
      child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listenWhen: (previous, current) =>
            previous.forgetPasswordState != current.forgetPasswordState,
        listener: (context, state) {
          if (state.forgetPasswordState.data != null &&
              state.forgetPasswordState.errorMessage == null) {
            context.push(RoutePath.validationCode);
          }
          {
            context.push(RoutePath.validationCode);
          }
        },

        builder: (BuildContext context, ForgetPasswordState state) {
          return Scaffold(
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
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(
                      S.of(context).forgetPassword,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 15),
                    Text(
                      S.of(context).enterEmailAssociatedToAccount,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        hintText: S.of(context).enterYourEmail,
                      ),
                      validator: AppValidator.validateEmail,
                    ),

                    SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (state.forgetPasswordState.isLoading == true)
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();

                            await viewModel.forgetPassword({
                              ApiKeys.email: email,
                            });
                          }
                        },
                        child: Text(S.of(context).confirm),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
