import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class OccasionView extends StatefulWidget {
  const OccasionView({super.key, required this.body, this.bottom});

  final Widget body;
  final PreferredSizeWidget? bottom;

  @override
  State<OccasionView> createState() => _OccasionViewState();
}

class _OccasionViewState extends State<OccasionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).occassions,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              S.of(context).sloganOfoccasion,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.lightGrey),
            ),
          ],
        ),
        bottom: widget.bottom,
      ),
      body: widget.body,
    );
  }
}
