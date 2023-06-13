import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/data/models/passport_dto.dart';
import 'package:test_test/data/repos/rest_repo.dart';
import 'package:test_test/data/services/rest_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashBoardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashBoardBloc({required this.restRepos}) : super(DashboardMainState(sendDataLoading: false)) {
    on<DashboardInitEvent>(_handleDashboardInitEvent);
    on<SendInfoDashboardEvent> (_handleSendInfoDashboardEvent);
  }
  final RestRepos restRepos;

  _handleDashboardInitEvent(DashboardInitEvent event, Emitter<DashboardState> emit) async {}

  _handleSendInfoDashboardEvent(SendInfoDashboardEvent event, Emitter<DashboardState> emit) async {
    try{
      emit(DashboardMainState(sendDataLoading: true));
      PassportDto passportDto = new PassportDto(
        firstName: event.firstName,
        lastName: event.lastName,
        age: event.age,
        documentNumber: event.documentNumber,
        dateOfBirth: event.dateOfBirth,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
        proof: event.imageBase64
      );
      await restRepos.postPassportInformation(passportDto: passportDto);
      // await restRepos.requestStatus();
      emit(DashboardMainState(sendDataLoading: false));
    } on DirectException catch (e) {
      emit(DashboardMainState(sendDataLoading: false));
      emit(DashboardErrorState(header: "Something went wring", message: e.message));
    }catch (e) {
      emit(DashboardMainState(sendDataLoading: false));
      emit(DashboardErrorState(header: "Something went wring", message: "An error happened during send data!"));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
