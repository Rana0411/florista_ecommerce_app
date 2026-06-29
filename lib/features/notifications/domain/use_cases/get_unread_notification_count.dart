import 'package:florista_ecommerce_app/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUnreadNotificationCountUseCase {
  final NotificationRepoContract _repo;
  GetUnreadNotificationCountUseCase(this._repo);

  Future<int> call() => _repo.getUnreadCount();
}
