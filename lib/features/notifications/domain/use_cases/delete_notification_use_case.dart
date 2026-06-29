import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteNotificationUseCase {
  final NotificationRepoContract _repo;
  DeleteNotificationUseCase(this._repo);

  Future<void> call(String id) => _repo.deleteNotification(id);
}
