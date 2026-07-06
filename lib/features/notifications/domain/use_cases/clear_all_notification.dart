import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearAllNotificationsUseCase {
  final NotificationRepoContract _repo;
  ClearAllNotificationsUseCase(this._repo);

  Future<void> call() => _repo.clearAll();
}
