import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllOccasionsUseCase {
  final HomeRepoContract homeRepoContract;

  GetAllOccasionsUseCase({required this.homeRepoContract});

  Future<BaseResponse<List<OccasionEntity>>> call() async {
    return await homeRepoContract.getAllOccasions();
  }
}
