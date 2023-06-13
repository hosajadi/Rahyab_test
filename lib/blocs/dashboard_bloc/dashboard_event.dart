part of 'dashboard_bloc.dart';

class DashboardEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DashboardInitEvent extends DashboardEvent{}
class SendInfoDashboardEvent extends DashboardEvent {
  final String firstName;
  final String lastName;
  final int age;
  final String documentNumber;
  final DateTime dateOfBirth;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String imageBase64;

  SendInfoDashboardEvent({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.documentNumber,
    required this.dateOfBirth,
    required this.issueDate,
    required this.expiryDate,
    required this.imageBase64
  });

  @override
  List<Object?> get props => [firstName, lastName, age, dateOfBirth, documentNumber, issueDate, expiryDate, imageBase64];
}