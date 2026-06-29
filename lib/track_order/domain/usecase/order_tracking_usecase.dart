import 'package:florista_ecommerce_app/track_order/domain/repo/order+tracking_repo_contract.dart';
import 'package:injectable/injectable.dart';
import '../entities/order_tracking_entity.dart';

@injectable
class WatchOrderTrackingUseCase {
  final OrderTrackingRepository repository;

  @factoryMethod
  WatchOrderTrackingUseCase(this.repository);

  Stream<OrderTrackingEntity?> call(String orderId) {
    return repository.watchOrderTracking(orderId);
  }
}