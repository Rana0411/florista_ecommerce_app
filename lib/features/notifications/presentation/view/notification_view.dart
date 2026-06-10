import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';
import '../widget/notification_title.dart';


class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsCubit>()..loadNotifications(),
      child: const _NotificationsBody(),
    );
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xff0C1015),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xff0C1015), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state.notifications.isEmpty) return const SizedBox.shrink();
              return PopupMenuButton<_MenuAction>(
                icon: const Icon(Icons.more_vert, color: Color(0xff0C1015)),
                onSelected: (action) =>
                    _handleMenuAction(context, action),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: _MenuAction.markAllRead,
                    child: Row(children: [
                      Icon(Icons.done_all, size: 18),
                      SizedBox(width: 10),
                      Text('Mark all as read'),
                    ]),
                  ),
                  const PopupMenuItem(
                    value: _MenuAction.clearAll,
                    child: Row(children: [
                      Icon(Icons.delete_sweep_outlined,
                          size: 18, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Clear all',
                          style: TextStyle(color: Colors.red)),
                    ]),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xffD21E6A)),
            );
          }

          if (state.errorMessage != null) {
            return _ErrorView(message: state.errorMessage!,
                onRetry: () =>
                    context.read<NotificationsCubit>().loadNotifications());
          }

          if (state.notifications.isEmpty) {
            return const _EmptyView();
          }

          return RefreshIndicator(
            color: const Color(0xffD21E6A),
            onRefresh: () =>
                context.read<NotificationsCubit>().loadNotifications(),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return NotificationTile(
                  notification: notification,
                  onTap: () => context
                      .read<NotificationsCubit>()
                      .markAsRead(notification.id),
                  onDelete: () => context
                      .read<NotificationsCubit>()
                      .deleteNotification(notification.id),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleMenuAction(BuildContext context, _MenuAction action) {
    final cubit = context.read<NotificationsCubit>();
    switch (action) {
      case _MenuAction.markAllRead:
        cubit.markAllAsRead();
      case _MenuAction.clearAll:
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Clear all notifications?'),
            content: const Text(
                'This will permanently delete all your notifications.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  cubit.clearAll();
                },
                child: const Text('Clear',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
    }
  }
}

enum _MenuAction { markAllRead, clearAll }

// ─── Empty state ───────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xffD21E6A).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined,
                size: 52,
                color: Color(0xffD21E6A),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff0C1015),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You're all caught up! We'll notify you about orders, offers, and more.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff535353),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Error state ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 52, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
