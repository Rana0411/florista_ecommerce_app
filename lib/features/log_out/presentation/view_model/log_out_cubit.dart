import 'package:equatable/equatable.dart';
import 'package:florista_ecommerce_app/config/base_state/base_state.dart';
import 'package:florista_ecommerce_app/config/handler/response_to_state_mapper.dart';
import 'package:florista_ecommerce_app/features/log_out/domain/use_case/log_out_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'log_out_state.dart';

@injectable
class LogOutCubit extends Cubit<LogOutState> {
  final LogOutUserUseCase _logOutUserUseCase;

  LogOutCubit(this._logOutUserUseCase) : super(LogOutState());

  Future<void> logOut() async {
    final response = await _logOutUserUseCase();
    final handler = ResponseToStateMapper.handle(response);
    emit(state.copyWith(logOutState: handler));
  }
}
