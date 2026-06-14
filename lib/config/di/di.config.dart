// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/forget_password/api/api_client/forget_password_api_client.dart'
    as _i478;
import '../../features/auth/forget_password/api/date_source/forget_password_data_source_impl.dart'
    as _i847;
import '../../features/auth/forget_password/data/data_source/forget_password_data_source_contract.dart'
    as _i170;
import '../../features/auth/forget_password/data/repo/forget_password_repo_impl.dart'
    as _i610;
import '../../features/auth/forget_password/domain/repo/forget_password_repo_contract.dart'
    as _i665;
import '../../features/auth/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i913;
import '../../features/auth/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i22;
import '../../features/auth/forget_password/domain/use_cases/verify_code_use_case.dart'
    as _i513;
import '../../features/auth/forget_password/presentation/view_model/forget_password_view_model.dart'
    as _i1033;
import '../../features/auth/login/data/data_source/login_local_data_source.dart'
    as _i349;
import '../../features/auth/login/data/data_source/login_remote_data_source.dart'
    as _i520;
import '../../features/auth/login/data/repo/login_repo_impl.dart' as _i1001;
import '../../features/auth/login/domain/repo/login_repo.dart' as _i632;
import '../../features/auth/login/domain/usecase/login_usecase.dart' as _i817;
import '../../features/auth/login/login_api/api_client.dart' as _i950;
import '../../features/auth/login/presentation/screen/login_cubit.dart'
    as _i629;
import '../../features/auth/sign-up/api/data_sources/sign_up_remote_data_source_impl.dart'
    as _i909;
import '../../features/auth/sign-up/api/sign_up_api_client/sign_up_api_client.dart'
    as _i973;
import '../../features/auth/sign-up/data/data_souurces/login_up_remote_data_source_contract.dart'
    as _i505;
import '../../features/auth/sign-up/data/repo/sign_up_repo_impl.dart' as _i437;
import '../../features/auth/sign-up/domain/repo/sign_up_repo_contract.dart'
    as _i754;
import '../../features/auth/sign-up/domain/use_cases/sign_up_use_cases.dart'
    as _i605;
import '../../features/auth/sign-up/presentation/view_model/sign_up_view_model.dart'
    as _i557;
import '../../features/best_seller/api/best_seller_api_client/best_seller_api_client.dart'
    as _i375;
import '../../features/best_seller/api/data_sources/best_seller_remote_data_source_impl.dart'
    as _i395;
import '../../features/best_seller/data/data_souurces/best_seller_remote_data_source_contract.dart'
    as _i995;
import '../../features/best_seller/data/repo/best_seller_repo_impl.dart'
    as _i1026;
import '../../features/best_seller/domain/repo/best_seller_repo_contract.dart'
    as _i949;
import '../../features/best_seller/domain/use_cases/best_seller_use_cases.dart'
    as _i722;
import '../../features/best_seller/presentation/view_model/best_seller_view_model.dart'
    as _i835;
import '../../features/cart/api/api_client/cart_api_client.dart' as _i673;
import '../../features/cart/api/data_sources/cart_remote_data_source_impl.dart'
    as _i866;
import '../../features/cart/data/data_sources/cart_remote_data_source_contract.dart'
    as _i447;
import '../../features/cart/data/repo/cart_repo_impl.dart' as _i234;
import '../../features/cart/domain/repo/cart_repo_contract.dart' as _i63;
import '../../features/cart/domain/use_cases/add_product_to_cart_use_case.dart'
    as _i473;
import '../../features/cart/domain/use_cases/clear_cart_use_case.dart' as _i493;
import '../../features/cart/domain/use_cases/get_cart_use_case.dart' as _i176;
import '../../features/cart/domain/use_cases/remove_product_from_cart_use_case.dart'
    as _i24;
import '../../features/cart/domain/use_cases/update_product_quantity_use_case.dart'
    as _i24;
import '../../features/cart/presentation/view_model/cart_cubit.dart' as _i818;
import '../../features/categories/api/api_client/categories_api_client.dart'
    as _i612;
import '../../features/categories/api/api_client/products_api_client.dart'
    as _i211;
import '../../features/categories/api/data_sources/categories_remote_data_source_impl.dart'
    as _i68;
import '../../features/categories/api/data_sources/products_remote_data_source_impl.dart'
    as _i1063;
import '../../features/categories/data/data_sources/categories_remote_data_source_contract.dart'
    as _i72;
import '../../features/categories/data/data_sources/products_remote_data_source_contract.dart'
    as _i502;
import '../../features/categories/data/repo/categories_repo_impl.dart' as _i706;
import '../../features/categories/data/repo/products_repo_impl.dart' as _i715;
import '../../features/categories/domain/repo/categories_repo_contract.dart'
    as _i233;
import '../../features/categories/domain/repo/products_repo_contract.dart'
    as _i747;
import '../../features/categories/domain/use_cases/categories_use_cases.dart'
    as _i900;
import '../../features/categories/domain/use_cases/get_products_by_category_use_case.dart'
    as _i293;
import '../../features/categories/presentation/cubit/categories_view_model.dart'
    as _i550;
import '../../features/change_password/api/api_client/change_password_api_client.dart'
    as _i244;
import '../../features/change_password/api/data_sources/change_password_remote_data_source_impl.dart'
    as _i788;
import '../../features/change_password/data/data_sources/change_password_remote_data_source_contract.dart'
    as _i365;
import '../../features/change_password/data/repo/change_password_repo_impl.dart'
    as _i534;
import '../../features/change_password/domain/repo/change_password_repo_contract.dart'
    as _i333;
import '../../features/change_password/domain/use_cases/change_password_use_case.dart'
    as _i874;
import '../../features/change_password/presentation/view_model/cubit/change_password_view_model.dart'
    as _i939;
import '../../features/edit_profile/api/api_client/edit_profile_api_client.dart'
    as _i690;
import '../../features/edit_profile/api/data_sources/edit_profile_remote_data_source_impl.dart'
    as _i46;
import '../../features/edit_profile/data/data_sources/edit_profile_remote_data_source_contract.dart'
    as _i228;
import '../../features/edit_profile/data/repo/edit_profile_repo_impl.dart'
    as _i440;
import '../../features/edit_profile/domain/repo/edit_profile_repo_contract.dart'
    as _i131;
import '../../features/edit_profile/domain/use_cases/upload_profile_data_use_case.dart'
    as _i600;
import '../../features/edit_profile/domain/use_cases/upload_profile_photo_use_case.dart'
    as _i1005;
import '../../features/edit_profile/presentation/view_model/cubit/edit_profile_view_model.dart'
    as _i70;
import '../../features/home/api/api_client/home_api_client.dart' as _i592;
import '../../features/home/api/data_sources/home_remote_data_source_impl.dart'
    as _i1033;
import '../../features/home/data/data_sources/home_remote_data_source_contract.dart'
    as _i582;
import '../../features/home/data/repo/home_repo_impl.dart' as _i1024;
import '../../features/home/domain/repo/home_repo_contract.dart' as _i396;
import '../../features/home/domain/use_cases/get_all_best_seller_use_case.dart'
    as _i758;
import '../../features/home/domain/use_cases/get_all_categories_use_case.dart'
    as _i431;
import '../../features/home/domain/use_cases/get_all_occasions_use_case.dart'
    as _i437;
import '../../features/home/domain/use_cases/get_logged_user_addresses_use_case.dart'
    as _i567;
import '../../features/home/presentation/view_model/home_view_model.dart'
    as _i77;
import '../../features/profile/api/api_client/profile_api_client.dart' as _i699;
import '../../features/profile/api/data_sources/profile_remote_data_source_impl.dart'
    as _i684;
import '../../features/profile/data/data_sources/profile_remote_data_source_contract.dart'
    as _i427;
import '../../features/profile/data/repo/profile_repo_impl.dart' as _i256;
import '../../features/profile/domain/repo/profile_repo_contract.dart' as _i541;
import '../../features/profile/domain/use_cases/get_user_data_use_case.dart'
    as _i941;
import '../../features/profile/presentation/view_model/profile_view_model.dart'
    as _i15;
import '../auth_interceptor/auth_interceptor.dart' as _i988;
import '../dio/dio_module.dart' as _i977;
import '../hive/hive_service.dart' as _i746;
import '../secure_storage/secure_storage_service.dart' as _i611;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i746.HiveService>(() => _i746.HiveService());
    gh.singleton<_i611.SecureStorageService>(
      () => _i611.SecureStorageService(),
    );
    gh.lazySingleton<_i988.AuthInterceptor>(
      () => _i988.AuthInterceptor(gh<_i611.SecureStorageService>()),
    );
    gh.singleton<_i361.Dio>(() => dioModule.dio(gh<_i988.AuthInterceptor>()));
    gh.factory<_i349.LoginLocalDataSource>(
      () => _i349.LoginLocalDataSourceImpl(gh<_i611.SecureStorageService>()),
    );
    gh.lazySingleton<_i375.BestSellerApiClient>(
      () => _i375.BestSellerApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i673.CartApiClient>(
      () => _i673.CartApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i612.CategoriesApiClient>(
      () => _i612.CategoriesApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i211.ProductsApiClient>(
      () => _i211.ProductsApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i244.ChangePasswordApiClient>(
      () => _i244.ChangePasswordApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i690.EditProfileApiClient>(
      () => _i690.EditProfileApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i592.HomeApiClient>(
      () => _i592.HomeApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i699.ProfileApiClient>(
      () => _i699.ProfileApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i478.ForgetPasswordApiClient>(
      () => _i478.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i950.ApiClient>(() => _i950.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i973.SignUpApiClient>(
      () => _i973.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i505.SignUpRemoteDataSourceContract>(
      () => _i909.SignUpRemoteDataSourceImpl(gh<_i973.SignUpApiClient>()),
    );
    gh.factory<_i447.CartRemoteDataSourceContract>(
      () =>
          _i866.CartRemoteDataSourceImpl(apiClient: gh<_i673.CartApiClient>()),
    );
    gh.factory<_i754.SignUpRepoContract>(
      () => _i437.SignUpRepoImpl(gh<_i505.SignUpRemoteDataSourceContract>()),
    );
    gh.factory<_i502.ProductsRemoteDataSourceContract>(
      () => _i1063.ProductsRemoteDataSourceImpl(
        productsApiClient: gh<_i211.ProductsApiClient>(),
      ),
    );
    gh.factory<_i72.CategoriesRemoteDataSourceContract>(
      () => _i68.CategoriesRemoteDataSourceImpl(
        categoriesApiClient: gh<_i612.CategoriesApiClient>(),
      ),
    );
    gh.factory<_i427.ProfileRemoteDataSourceContract>(
      () => _i684.ProfileRemoteDataSourceImpl(
        profileApiClient: gh<_i699.ProfileApiClient>(),
      ),
    );
    gh.factory<_i520.LoginRemoteDataSource>(
      () => _i520.LoginRemoteDataSourceImpl(gh<_i950.ApiClient>()),
    );
    gh.factory<_i605.SignUpUseCases>(
      () => _i605.SignUpUseCases(gh<_i754.SignUpRepoContract>()),
    );
    gh.factory<_i557.SignUpViewModel>(
      () => _i557.SignUpViewModel(
        signUpUseCases: gh<_i605.SignUpUseCases>(),
        secureStorageService: gh<_i611.SecureStorageService>(),
      ),
    );
    gh.factory<_i995.BestSellerRemoteDataSourceContract>(
      () => _i395.BestSellerRemoteDataSourceImpl(
        apiClient: gh<_i375.BestSellerApiClient>(),
      ),
    );
    gh.factory<_i365.ChangePasswordRemoteDataSourceContract>(
      () => _i788.ChangePasswordRemoteDataSourceImpl(
        changePasswordApiClient: gh<_i244.ChangePasswordApiClient>(),
      ),
    );
    gh.factory<_i63.CartRepoContract>(
      () => _i234.CartRepoImpl(
        cartRemoteDataSourceContract: gh<_i447.CartRemoteDataSourceContract>(),
        secureStorageService: gh<_i611.SecureStorageService>(),
      ),
    );
    gh.factory<_i170.ForgetPasswordDataSourceContract>(
      () => _i847.ForgetPasswordDataSourceImpl(
        forgetPasswordApiClient: gh<_i478.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i747.ProductsRepoContract>(
      () => _i715.ProductsRepoImpl(
        productsRemoteDataSourceContract:
            gh<_i502.ProductsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i632.LoginRepo>(
      () => _i1001.LoginRepoImpl(
        gh<_i520.LoginRemoteDataSource>(),
        gh<_i349.LoginLocalDataSource>(),
      ),
    );
    gh.factory<_i582.HomeRemoteDataSourceContract>(
      () => _i1033.HomeRemoteDataSourceImpl(
        homeApiClient: gh<_i592.HomeApiClient>(),
      ),
    );
    gh.factory<_i665.ForgetPasswordRepoContract>(
      () => _i610.ForgetPasswordRepoImpl(
        forgetPasswordDataSource: gh<_i170.ForgetPasswordDataSourceContract>(),
      ),
    );
    gh.factory<_i541.ProfileRepoContract>(
      () => _i256.ProfileRepoImpl(
        profileRemoteDataSourceContract:
            gh<_i427.ProfileRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i228.EditProfileRemoteDataSourceContract>(
      () => _i46.EditProfileRemoteDataSourceImpl(
        editProfileApiClient: gh<_i690.EditProfileApiClient>(),
      ),
    );
    gh.factory<_i293.GetProductsByCategoryUseCase>(
      () => _i293.GetProductsByCategoryUseCase(
        productsRepoContract: gh<_i747.ProductsRepoContract>(),
      ),
    );
    gh.factory<_i817.LoginUseCase>(
      () => _i817.LoginUseCase(gh<_i632.LoginRepo>()),
    );
    gh.factory<_i473.AddProductToCartUseCase>(
      () => _i473.AddProductToCartUseCase(
        cartRepoContract: gh<_i63.CartRepoContract>(),
      ),
    );
    gh.factory<_i493.ClearCartUseCase>(
      () =>
          _i493.ClearCartUseCase(cartRepoContract: gh<_i63.CartRepoContract>()),
    );
    gh.factory<_i176.GetCartUseCase>(
      () => _i176.GetCartUseCase(cartRepoContract: gh<_i63.CartRepoContract>()),
    );
    gh.factory<_i24.RemoveProductFromCartUseCase>(
      () => _i24.RemoveProductFromCartUseCase(
        cartRepoContract: gh<_i63.CartRepoContract>(),
      ),
    );
    gh.factory<_i24.UpdateProductQuantityUseCase>(
      () => _i24.UpdateProductQuantityUseCase(
        cartRepoContract: gh<_i63.CartRepoContract>(),
      ),
    );
    gh.factory<_i396.HomeRepoContract>(
      () => _i1024.HomeRepoImpl(
        homeRemoteDataSourceContract: gh<_i582.HomeRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i629.LoginCubit>(
      () => _i629.LoginCubit(gh<_i817.LoginUseCase>()),
    );
    gh.factory<_i949.BestSellerRepoContract>(
      () => _i1026.BestSellerRepoImpl(
        dataSource: gh<_i995.BestSellerRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i131.EditProfileRepoContract>(
      () => _i440.EditProfileRepoImpl(
        editProfileRemoteDataSourceContract:
            gh<_i228.EditProfileRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i233.CategoriesRepoContract>(
      () => _i706.CategoriesRepoImpl(
        categoriesRemoteDataSourceContract:
            gh<_i72.CategoriesRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i600.UploadProfileDataUseCase>(
      () => _i600.UploadProfileDataUseCase(
        editProfileRepoContract: gh<_i131.EditProfileRepoContract>(),
      ),
    );
    gh.factory<_i1005.UploadProfilePhotoUseCase>(
      () => _i1005.UploadProfilePhotoUseCase(
        editProfileRepoContract: gh<_i131.EditProfileRepoContract>(),
      ),
    );
    gh.factory<_i70.EditProfileViewModel>(
      () => _i70.EditProfileViewModel(
        uploadProfileData: gh<_i600.UploadProfileDataUseCase>(),
        uploadProfilePhotoUseCase: gh<_i1005.UploadProfilePhotoUseCase>(),
      ),
    );
    gh.factory<_i333.ChangePasswordRepoContract>(
      () => _i534.ChangePasswordRepoImpl(
        changePasswordRemoteDataSourceContract:
            gh<_i365.ChangePasswordRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i758.GetAllBestSellerUseCase>(
      () => _i758.GetAllBestSellerUseCase(
        homeRepoContract: gh<_i396.HomeRepoContract>(),
      ),
    );
    gh.factory<_i431.GetAllCategoriesUseCase>(
      () => _i431.GetAllCategoriesUseCase(
        homeRepoContract: gh<_i396.HomeRepoContract>(),
      ),
    );
    gh.factory<_i437.GetAllOccasionsUseCase>(
      () => _i437.GetAllOccasionsUseCase(
        homeRepoContract: gh<_i396.HomeRepoContract>(),
      ),
    );
    gh.factory<_i567.GetLoggedUserAddressesUseCase>(
      () => _i567.GetLoggedUserAddressesUseCase(
        homeRepoContract: gh<_i396.HomeRepoContract>(),
      ),
    );
    gh.factory<_i818.CartCubit>(
      () => _i818.CartCubit(
        getCartUseCase: gh<_i176.GetCartUseCase>(),
        addProductToCartUseCase: gh<_i473.AddProductToCartUseCase>(),
        removeProductFromCartUseCase: gh<_i24.RemoveProductFromCartUseCase>(),
        updateProductQuantityUseCase: gh<_i24.UpdateProductQuantityUseCase>(),
        clearCartUseCase: gh<_i493.ClearCartUseCase>(),
      ),
    );
    gh.factory<_i722.GetBestSellerUseCase>(
      () => _i722.GetBestSellerUseCase(
        bestSellerRepoContract: gh<_i949.BestSellerRepoContract>(),
      ),
    );
    gh.factory<_i913.ForgetPasswordUseCase>(
      () => _i913.ForgetPasswordUseCase(
        forgetPasswordRepo: gh<_i665.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i22.ResetPasswordUseCase>(
      () => _i22.ResetPasswordUseCase(
        forgetPasswordRepo: gh<_i665.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i513.VerifyCodeUseCase>(
      () => _i513.VerifyCodeUseCase(
        forgetPasswordRepo: gh<_i665.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i941.GetUserDataUseCase>(
      () => _i941.GetUserDataUseCase(
        profileRepoContract: gh<_i541.ProfileRepoContract>(),
      ),
    );
    gh.factory<_i900.GetCategoriesUseCase>(
      () => _i900.GetCategoriesUseCase(
        categoriesRepoContract: gh<_i233.CategoriesRepoContract>(),
      ),
    );
    gh.factory<_i874.ChangePasswordUseCase>(
      () => _i874.ChangePasswordUseCase(
        changePasswordRepoContract: gh<_i333.ChangePasswordRepoContract>(),
      ),
    );
    gh.factory<_i15.ProfileViewModel>(
      () => _i15.ProfileViewModel(
        getUserDataUseCase: gh<_i941.GetUserDataUseCase>(),
      ),
    );
    gh.factory<_i77.HomeViewModel>(
      () => _i77.HomeViewModel(
        getAllCategoriesUseCase: gh<_i431.GetAllCategoriesUseCase>(),
        getAllBestSellerUseCase: gh<_i758.GetAllBestSellerUseCase>(),
        getAllOccasionsUseCase: gh<_i437.GetAllOccasionsUseCase>(),
        getLoggedUserAddressesUseCase:
            gh<_i567.GetLoggedUserAddressesUseCase>(),
      ),
    );
    gh.factory<_i939.ChangePasswordViewModel>(
      () => _i939.ChangePasswordViewModel(
        changePasswordUseCase: gh<_i874.ChangePasswordUseCase>(),
      ),
    );
    gh.factory<_i550.CategoriesCubit>(
      () => _i550.CategoriesCubit(
        getCategoriesUseCase: gh<_i900.GetCategoriesUseCase>(),
        getProductsByCategoryUseCase: gh<_i293.GetProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i835.BestSellerViewModel>(
      () => _i835.BestSellerViewModel(
        getBestSellerUseCase: gh<_i722.GetBestSellerUseCase>(),
      ),
    );
    gh.factory<_i1033.ForgetPasswordViewModel>(
      () => _i1033.ForgetPasswordViewModel(
        forgetPasswordUseCase: gh<_i913.ForgetPasswordUseCase>(),
        resetPasswordUseCase: gh<_i22.ResetPasswordUseCase>(),
        confirmValidationCodeUseCase: gh<_i513.VerifyCodeUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
