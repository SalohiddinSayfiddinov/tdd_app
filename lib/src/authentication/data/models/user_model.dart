import 'dart:convert';

import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.phone,
    required super.name,
    required super.surname,
    required super.hasSeen,
    required super.contract,
    required super.report,
    required super.isActive,
    required super.isStaff,
    required super.isSuperuser,
    required super.dateJoined,
  });

  factory UserModel.empty() {
    return const UserModel(
      id: 0,
      phone: "",
      name: "",
      surname: "",
      hasSeen: false,
      contract: null,
      report: null,
      isActive: true,
      isStaff: false,
      isSuperuser: false,
      dateJoined: "",
    );
  }

  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(jsonDecode(source));
  }

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as int,
      phone: map['phone'] as String,
      name: map['name'] as String? ?? "",
      surname: map['surname'] as String? ?? "",
      hasSeen: map['has_seen'] as bool? ?? false,
      contract: map['contract'] as String?,
      report: map['report'] as String?,
      isActive: map['is_active'] as bool? ?? true,
      isStaff: map['is_staff'] as bool? ?? false,
      isSuperuser: map['is_superuser'] as bool? ?? false,
      dateJoined: map['date_joined'] as String? ?? "",
    );
  }

  UserModel copyWith({
    int? id,
    String? phone,
    String? name,
    String? surname,
    bool? hasSeen,
    String? contract,
    String? report,
    bool? isActive,
    bool? isStaff,
    bool? isSuperuser,
    String? dateJoined,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      hasSeen: hasSeen ?? this.hasSeen,
      contract: contract ?? this.contract,
      report: report ?? this.report,
      isActive: isActive ?? this.isActive,
      isStaff: isStaff ?? this.isStaff,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  DataMap toMap() => {
        'id': id,
        'phone': phone,
        'name': name,
        'surname': surname,
        'has_seen': hasSeen,
        'contract': contract,
        'report': report,
        'is_active': isActive,
        'is_staff': isStaff,
        'is_superuser': isSuperuser,
        'date_joined': dateJoined,
      };

  String toJson() => jsonEncode(toMap());
}
