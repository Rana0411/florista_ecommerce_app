import 'package:florista_ecommerce_app/core/router/nav_helper.dart';
import 'package:florista_ecommerce_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(child: Text("Profile")),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
