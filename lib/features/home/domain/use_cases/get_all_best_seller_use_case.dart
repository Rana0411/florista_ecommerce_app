import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllBestSellerUseCase {
  final HomeRepoContract homeRepoContract;

  GetAllBestSellerUseCase({required this.homeRepoContract});

  Future<BaseResponse<List<BestSellerEntity>>> call() {
    return homeRepoContract.getAllBestSeller();
  }
}
