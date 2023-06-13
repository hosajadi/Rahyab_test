part of 'dashboard_bloc.dart';

class DashboardEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DashboardInitEvent extends DashboardEvent{}
class SendInfoDashboardEvent extends DashboardEvent {
  final String firstName;
  final String lastName;
  final String age;
  final String documentNumber;
  final DateTime? dateOfBirth;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String? proof;

  SendInfoDashboardEvent({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.documentNumber,
    this.dateOfBirth,
    this.issueDate,
    this.expiryDate,
    this.proof
  });

  SendInfoDashboardEvent copyWith({
    String? firstName,
    String? lastName,
    String? age,
    String? documentNumber,
    DateTime? dateOfBirth,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? proof
  }){
    return SendInfoDashboardEvent(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      documentNumber: documentNumber ?? this.documentNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      proof: proof ?? this.proof
    );
}

  @override
  List<Object?> get props => [firstName, lastName, age, dateOfBirth, documentNumber, issueDate, expiryDate, proof];
}

class SetBirthDayDateDashboardEvent extends DashboardEvent{
  final DateTime date;

  SetBirthDayDateDashboardEvent(this.date);

  List<Object?> get props => [date,identityHashCode(this)];
}

class SetIssueDateDashboardEvent extends DashboardEvent{
  final DateTime date;

  SetIssueDateDashboardEvent(this.date);
  List<Object?> get props => [date, identityHashCode(this)];
}

class SetExpiryDatDashboardEvent extends DashboardEvent{
  final DateTime date;

  SetExpiryDatDashboardEvent(this.date);
  List<Object?> get props => [date, identityHashCode(this)];
}

class LoadImageDashboardEvent extends DashboardEvent {
  List<Object?> get props => [identityHashCode(this)];
}