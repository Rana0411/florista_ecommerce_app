import 'package:florista_ecommerce_app/config/di/di.dart';
import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/app_language/locale_cubit.dart';
import 'package:florista_ecommerce_app/features/log_out/presentation/view/widgets/log_out_dialog.dart';
import 'package:florista_ecommerce_app/features/log_out/presentation/view_model/log_out_cubit.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/language_tile.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/notification_tile.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/profile_tile.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/profile_user_data_column.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, _) {
        final strings = S.of(context);

        return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: Row(
          children: [
            Image.asset(AssetsManager.flower12Px, width: 24, height: 24),

            const SizedBox(width: 6),

            Text(
              strings.flowery,
              style: TextStyle(
                fontFamily: AppFonts.imfEllEnglish,
                color: AppColors.primary,
                fontSize: 20,
              ),
            ),

            Spacer(),

            Icon(Icons.notifications_outlined),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileUserDataColumn(),

              SizedBox(height: 32),

              // My orders
              ProfileTile(
                icon: Icons.book_outlined,
                title: strings.myOrders,
                onTap: () {},
              ),

              // Saved address
              ProfileTile(
                icon: Icons.place_outlined,
                title: strings.savedAddress,
                onTap: () {},
              ),

              Divider(),

              // Notification
              NotificationTile(),

              Divider(),

              LanguageTile(onPressed: () {}),

              // About us
              ProfileTile(title: strings.aboutUs, onTap: () {}),

              // Terms & Conditions
              ProfileTile(title: strings.termsConditions, onTap: () {}),

              Divider(height: 32),

              ProfileTile(
                icon: Icons.logout,
                title: strings.logout,
                isLogout: true,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) => BlocProvider(
                      create: (context) => getIt.get<LogOutCubit>(),
                      child: const LogOutDialog(),
                    ),
                  );
                },
              ),

              Spacer(),

              Text(
                strings.virson,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeightManager.regular,
                  color: AppColors.lightGrey,
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
        );
      },
    );
  }
}
