import 'package:injectable/injectable.dart';

import '../entities/notification_entity.dart';
import '../repo/notification_repo_contract.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationRepoContract _repo;
  GetNotificationsUseCase(this._repo);

  Future<List<NotificationEntity>> call() => _repo.getNotifications();
}

@injectable
class SaveNotificationUseCase {
  final NotificationRepoContract _repo;
  SaveNotificationUseCase(this._repo);

  Future<void> call(NotificationEntity notification) =>
      _repo.saveNotification(notification);
}

@injectable
class MarkNotificationAsReadUseCase {
  final NotificationRepoContract _repo;
  MarkNotificationAsReadUseCase(this._repo);

  Future<void> call(String id) => _repo.markAsRead(id);
}

@injectable
class MarkAllNotificationsAsReadUseCase {
  final NotificationRepoContract _repo;
  MarkAllNotificationsAsReadUseCase(this._repo);

  Future<void> call() => _repo.markAllAsRead();
}

@injectable
class DeleteNotificationUseCase {
  final NotificationRepoContract _repo;
  DeleteNotificationUseCase(this._repo);

  Future<void> call(String id) => _repo.deleteNotification(id);
}

@injectable
class ClearAllNotificationsUseCase {
  final NotificationRepoContract _repo;
  ClearAllNotificationsUseCase(this._repo);

  Future<void> call() => _repo.clearAll();
}

@injectable
class GetUnreadNotificationCountUseCase {
  final NotificationRepoContract _repo;
  GetUnreadNotificationCountUseCase(this._repo);

  Future<int> call() => _repo.getUnreadCount();
}
