import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_test/data/models/passport_dto.dart';
import 'package:test_test/data/repos/rest_repo.dart';
import 'package:test_test/data/services/rest_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashBoardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashBoardBloc({required this.restRepos}) : super(DashboardMainState(sendDataLoading: false)) {
    on<DashboardInitEvent>(_handleDashboardInitEvent);
    on<SendInfoDashboardEvent> (_handleSendInfoDashboardEvent);
    on<SetBirthDayDateDashboardEvent>(_handleSetBirthDayDateDashboardEvent);
    on<SetIssueDateDashboardEvent>(_handleSetIssueDateDashboardEvent);
    on<SetExpiryDatDashboardEvent>(_handleSetExpiryDatDashboardEvent);
    on<LoadImageDashboardEvent>(_handleLoadImageDashboardEvent);
  }
  final RestRepos restRepos;
  DateTime? dateOfBirth;
  DateTime? issueDate;
  DateTime? expiryDate;
  String? proof;

  _handleDashboardInitEvent(DashboardInitEvent event, Emitter<DashboardState> emit) async {}

  _handleSetBirthDayDateDashboardEvent(SetBirthDayDateDashboardEvent event, Emitter<DashboardState> emit ) async {
    dateOfBirth = event.date;
    print(dateOfBirth);
  }

  _handleSetIssueDateDashboardEvent(SetIssueDateDashboardEvent event, Emitter<DashboardState> emit ) async {
    issueDate = event.date;
  }

  _handleSetExpiryDatDashboardEvent(SetExpiryDatDashboardEvent event, Emitter<DashboardState> emit ) async {
    expiryDate = event.date;
  }

  _handleLoadImageDashboardEvent(LoadImageDashboardEvent event, Emitter<DashboardState> emit ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      proof = base64.encode(imageBytes);
    }
  }

  _handleSendInfoDashboardEvent(SendInfoDashboardEvent event, Emitter<DashboardState> emit) async {
    try{
      event = event.copyWith(dateOfBirth: dateOfBirth, issueDate: issueDate, expiryDate: expiryDate, proof: proof);
      if (! _checkValidity(event: event)) {
        emit (DashboardErrorState(header: "Invalid values", message: "Please provide all requirement parameters"));
      } else {
        emit(DashboardMainState(sendDataLoading: true));
        PassportDto passportDto = new PassportDto(
            firstName: event.firstName,
            lastName: event.lastName,
            age: int.parse(event.age),
            documentNumber: event.documentNumber,
            dateOfBirth: event.dateOfBirth!,
            issueDate: event.issueDate!,
            expiryDate: event.expiryDate!,
            proof: event.proof!
        );
        await restRepos.postPassportInformation(passportDto: passportDto);
      }
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

  bool _checkValidity({required SendInfoDashboardEvent event}) {
    if (
    event.firstName.length == 0 ||
        event.lastName.length == 0 ||
        event.documentNumber.length == 0 ||
        event.age.length == 0 ||
        event.dateOfBirth == null ||
        event.issueDate == null ||
        event.expiryDate == null ||
        event.proof == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
