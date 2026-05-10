import 'package:florista_ecommerce_app/config/text_field_validator.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ResetPasswordView  extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController =  TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
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
                S.of(context).passwordMustBeAtLeastCharacters,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: S.of(context).password,
                  hintText: S.of(context).enterYourPassword,
                ),
                validator: AppValidator.validateEmail,
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: S.of(context).confirmPassword,
                  hintText: S.of(context).confirmPassword,
                ),
                validator: AppValidator.validateEmail,
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
  }
}
