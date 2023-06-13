import 'package:intl/intl.dart';

enum Gender {
  M,
  m,
  F,
  f,
  O,
  o
}
extension ParseToString on Gender {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class Name {
  final String firstName;
  final String lastName;
  Name({required this.firstName, required this.lastName});

  Map<String, dynamic> jsonForm(){
    return {
      'first_name': this.firstName,
      'last_name': this.lastName,
    };
  }
}

class PassportDto{
  final String firstName;

  final String lastName;

  //yyyy-mm-dd
  final DateTime dateOfBirth;

  final int age;

  final Gender? gender;

  //Example: 2015-12-31
  final DateTime issueDate;

  //Example: 2025-12-31
  final DateTime expiryDate;

  //Example: 35201-0000000-0, ABC1234XYZ098
  final String documentNumber;

  final String proof;

  PassportDto({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.age,
    this.gender,
    required this.issueDate,
    required this.expiryDate,
    required this.documentNumber,
    required this.proof});

  PassportDto copyWith({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    int? age,
    Gender? gender,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? documentNumber,
    String? prof,
  }) {
    return PassportDto(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      documentNumber: documentNumber ?? this.documentNumber,
      proof: prof ?? this.proof,
    );
  }

  Map<String, dynamic> jsonForm(){
    Name? name;
    if (this.firstName != null && this.lastName != null) {
      name = Name(firstName: this.firstName!, lastName: this.lastName!);
    }

    return {
      "name": name == null ? null : name.jsonForm(),
      "dob": this.dateOfBirth == null ? "" : this.dateOfBirth!.year.toString() + "-" + this.dateOfBirth!.month.toString() + "-" + this.dateOfBirth!.day.toString(),
      "age": age,
      "gender": this.gender == null ? "M" : this.gender!.toShortString(),
      "issue_date": this.issueDate == null ? "" : this.issueDate!.year.toString() + "-" + this.issueDate!.month.toString() + "-" + this.issueDate!.day.toString(),
      "expiry_date": this.expiryDate ==null ? "" : this.expiryDate!.year.toString() + "-" + this.expiryDate!.month.toString() + "-" + this.expiryDate!.day.toString(),
      "document_number": this.documentNumber ?? "",
      "proof": this.proof ?? "",
      "supported_types" : ["passport"],
      "allow_offline": "1",
      "allow_online": "1",
      "fetch_enhanced_data": "0",
      "backside_proof_required": "0",
      "allow_ekyc": "0",
    };
  }
}