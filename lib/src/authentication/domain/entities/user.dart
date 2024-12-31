import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.phone,
    required this.name,
    required this.surname,
    required this.hasSeen,
    required this.contract,
    required this.report,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    required this.dateJoined,
  });

  factory User.empty() {
    return const User(
      id: 0,
      phone: "",
      name: "",
      surname: "",
      hasSeen: false,
      contract: null,
      report: null,
      isActive: false,
      isStaff: false,
      isSuperuser: false,
      dateJoined: "",
    );
  }

  final int id;
  final String phone;
  final String name;
  final String surname;
  final bool hasSeen;
  final String? contract;
  final String? report;
  final bool isActive;
  final bool isStaff;
  final bool isSuperuser;
  final String dateJoined;

  @override
  List<Object?> get props => [
        id,
        phone,
        name,
        surname,
        hasSeen,
        contract,
        report,
        isActive,
        isStaff,
        isSuperuser,
        dateJoined,
      ];
}
