import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/authentication/data/models/user_model.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = UserModel.empty();
  test('should be a subclass of [User] entity', () {
    // Arrange

    // Act

    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] with the right data', () {
      // Act
      final result = tModel.toJson();
      final fakeJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      // Assert
      expect(result, equals(fakeJson));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      // Act
      final result = tModel.copyWith(name: "Paul");

      // Assert
      expect(result.name, equals('Paul'));
    });
  });
}
