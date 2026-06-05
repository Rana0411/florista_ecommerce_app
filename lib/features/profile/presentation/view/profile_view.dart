import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/core/utils/assets_manager.dart';
import 'package:florista_ecommerce_app/core/utils/fonts_manager.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/language_tile.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/notification_tile.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/profile_tile.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/widgets/profile_user_data_column.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared_widgets/web_view_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: Row(
          children: [
            Image.asset(AssetsManager.flower12Px, width: 24, height: 24),

            const SizedBox(width: 6),

            Text(
              S.current.flowery,
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
                title: S.current.myOrders,
                onTap: () {},
              ),

              // Saved address
              ProfileTile(
                icon: Icons.place_outlined,
                title: S.current.savedAddress,
                onTap: () {},
              ),

              Divider(),

              // Notification
              NotificationTile(),

              Divider(),

              //TODO: Apply Language Logic here @Rana0411
              LanguageTile(),

              // About us
              ProfileTile(
                title: S.of(context).aboutUs, // or whatever your string is
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WebViewScreen(
                        url:
                            'https://elevate-flutter-team.github.io/flower_app_web_views/about.html',
                        title: 'About Us',
                      ),
                    ),
                  );
                },
              ),
              // Terms & Conditions
              ProfileTile(
                title: S.current.termsConditions,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(
                      url:
                          'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html',
                      title: 'Terms & Conditions',
                    ),
                  ),
                ),
              ),
              Divider(height: 32),

              //TODO: Apply Logout Logic here @Rana0411
              ProfileTile(
                icon: Icons.logout,
                title: S.current.logout,
                isLogout: true,
                onTap: () {},
              ),

              Spacer(),

              Text(
                S.current.virson,
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
  }
}
