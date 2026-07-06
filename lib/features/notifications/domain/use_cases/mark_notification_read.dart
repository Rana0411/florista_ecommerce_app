import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkNotificationAsReadUseCase {
  final NotificationRepoContract _repo;
  MarkNotificationAsReadUseCase(this._repo);

  Future<void> call(String id) => _repo.markAsRead(id);
}
