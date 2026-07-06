import 'package:florista_ecommerce_app/core/router/route_path.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:florista_ecommerce_app/features/log_out/presentation/view_model/log_out_cubit.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:go_router/go_router.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state.logOutState.data != null) {
          if (!context.mounted) return;

          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RoutePath.login, (route) => false);
        }

        if (state.logOutState.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.logOutState.errorMessage ?? S.of(context).logoutFailed,
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.logOutState.isLoading == true;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.white,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.w(context, 0.06),
                vertical: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).logoutTitle,
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s18,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).logoutConfirmation,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: FontSize.s14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: AppColors.lightGrey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            S.of(context).cancel,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<LogOutCubit>().logOut();
                                  context.go(RoutePath.login);
                                },
                          child: isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  S.of(context).logout,
                                  style: TextStyle(
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
