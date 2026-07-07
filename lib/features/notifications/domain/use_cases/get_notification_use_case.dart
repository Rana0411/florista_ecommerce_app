import 'package:florista_ecommerce_app/features/notifications/domain/entity/notification_entity.dart';
import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationRepoContract _repo;
  GetNotificationsUseCase(this._repo);

  Future<List<NotificationEntity>> call() => _repo.getNotifications();
}