import 'package:florista_ecommerce_app/features/notifications/domain/entity/notification_entity.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveNotificationUseCase {
  final NotificationRepoContract _repo;
  SaveNotificationUseCase(this._repo);

  Future<void> call(NotificationEntity notification) =>
      _repo.saveNotification(notification);
}
