import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/di.dart';
import '../../../../core/router/route_path.dart';

import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<NotificationsCubit>()..refreshUnreadCount(),
      child: const _DrawerContent(),
    );
  }
}

class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────────
            _DrawerHeader(),

            const Divider(height: 1),

            // ── Menu items ──────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.home);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.category_outlined,
                    label: 'Categories',
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.categories);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Cart',
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.cart);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.favorite_outline,
                    label: 'Wishlist',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: navigate to wishlist when built
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'My Orders',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: navigate to orders when built
                    },
                  ),

                  // ── Notifications with badge ─────────────────────────────
                  BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      return _DrawerItem(
                        icon: Icons.notifications_outlined,
                        label: 'Notifications',
                        badge: state.unreadCount > 0
                            ? state.unreadCount
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          context.push(RoutePath.notifications);
                        },
                      );
                    },
                  ),

                  const Divider(height: 24),

                  _DrawerItem(
                    icon: Icons.person_outline,
                    label: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.profile);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: navigate to settings when built
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // ── Logout ──────────────────────────────────────────────────────
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.red),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log out?'),
        content:
        const Text('Are you sure you want to log out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // close drawer
              context.go(RoutePath.login);
            },
            child: const Text('Log out',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ─── Header ─────────────────────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xffD21E6A).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xffD21E6A),
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Florista User',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff0C1015),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                const Text(
                  'user@florista.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff535353),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Drawer item ──────────────────────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? badge;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: const Color(0xff535353), size: 24),
          if (badge != null)
            Positioned(
              top: -4,
              right: -6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xffD21E6A),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  badge! > 99 ? '99+' : '$badge',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff0C1015),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      horizontalTitleGap: 8,
    );
  }
}
