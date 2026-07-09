import 'package:flutter/material.dart';

import 'package:florista_ecommerce_app/core/utils/app_colors.dart';
import 'package:florista_ecommerce_app/generated/l10n.dart';
import '../cubit/categories_state.dart';

class SortSheet extends StatefulWidget {
  final SortOption? selectedSort;
  final VoidCallback onClose;
  final ValueChanged<SortOption> onApply;

  const SortSheet({
    super.key,
    required this.selectedSort,
    required this.onClose,
    required this.onApply,
  });

  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet>
    with SingleTickerProviderStateMixin {
  late SortOption? _selected;
  late AnimationController _ctrl;
  late Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedSort;
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 280));
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _dismiss() {
    _ctrl.reverse().then((_) => widget.onClose());
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      (SortOption.lowestPrice, S.of(context).lowestPrice),
      (SortOption.highestPrice, S.of(context).highestPrice),
      (SortOption.newest, S.of(context).newest),
      (SortOption.oldest, S.of(context).oldest),
      (SortOption.discount, S.of(context).discount),
    ];

    return GestureDetector(
      onTap: _dismiss,
      child: Container(
        color: Colors.black.withOpacity(0.35),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: SlideTransition(
              position: Tween<Offset>(
                  begin: const Offset(0, 1), end: Offset.zero)
                  .animate(_slide),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).sortBy,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Options
                    ...options.map((opt) {
                      final isSelected = _selected == opt.$1;
                      return GestureDetector(
                        onTap: () => setState(() => _selected = opt.$1),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : const Color(0xFFF0F0F0)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  opt.$2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: AppColors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFFCCCCCC),
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _selected == null
                            ? null
                            : () => widget.onApply(_selected!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                        ),
                        icon: const Icon(Icons.tune,
                            color: Colors.white, size: 18),
                        label: Text(
                          S.of(context).filter,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}