import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkAllNotificationsAsReadUseCase {
  final NotificationRepoContract _repo;
  MarkAllNotificationsAsReadUseCase(this._repo);

  Future<void> call() => _repo.markAllAsRead();
}
