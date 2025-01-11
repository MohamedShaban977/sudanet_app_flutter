import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/forget_password_request.dart';
import '../../domain/use_cases/forget_password_use_case.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({required this.forgetPasswordUseCases})
      : super(ForgetPasswordInitial());

  final ForgetPasswordUseCases forgetPasswordUseCases;

  ForgetPasswordCubit get(context) => BlocProvider.of(context);

  Future<void> forgetPassword(ForgetPasswordRequest request) async {
    emit(ForgetPasswordLoadingState());
    Either<Failure, BaseResponseEntity<String>> response =
        await forgetPasswordUseCases.call(request);

    response.fold(
      (failure) => emit(ForgetPasswordErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(ForgetPasswordSuccessState(response: response)),
    );
  }
}
