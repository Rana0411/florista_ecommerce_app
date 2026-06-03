import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/config/shared_models/user_data/user_request_dto.dart';
import 'package:florista_ecommerce_app/features/profile/domain/use_cases/get_user_data_use_case.dart';
import 'package:florista_ecommerce_app/features/profile/presentation/view_model/profile_events.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetUserDataUseCase getUserDataUseCase;
  ProfileViewModel({required this.getUserDataUseCase}) : super(ProfileState());

  void doEvent(ProfileEvents event) {
    switch (event) {
      case GetUserDataEvent():
        _getUserData();
        break;
    }
  }

  Future<void> _getUserData() async {
    emit(
      state.copyWith(
        getUserDatastate: state.getUserDatastate.copyWith(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await getUserDataUseCase();
    final handler = ResponseToStateMapper.handle<UserRequestDto>(response);

    emit(
      state.copyWith(
        getUserDatastate: state.getUserDatastate.copyWith(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
