import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/models/occasion_entity.dart';
import 'package:florista_ecommerce_app/features/occasions/domain/repo/occasions_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllOccasionsUseCase {
  final OccasionsRepoContract occasionRepoContract;

  GetAllOccasionsUseCase({required this.occasionRepoContract});

  Future<BaseResponse<List<OccasionEntity>>> call() async {
    return await occasionRepoContract.getAllOccasions();
  }
}
