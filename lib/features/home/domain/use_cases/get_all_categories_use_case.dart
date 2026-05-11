import 'package:florista_ecommerce_app/config/base_response/base_response.dart';
import 'package:florista_ecommerce_app/features/home/domain/entities/category_entity.dart';
import 'package:florista_ecommerce_app/features/home/domain/repo/home_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase {
  final HomeRepoContract homeRepoContract;

  GetAllCategoriesUseCase({required this.homeRepoContract});

  Future<BaseResponse<List<CategoryEntity>>> call() async {
    return await homeRepoContract.getAllCategories();
  }
}
