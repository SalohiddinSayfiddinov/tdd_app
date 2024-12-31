import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_app/core/constants/constants.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group(
    'createUser',
    () {
      test('should complete successfully when the status code is 200 or 201',
          () async {
        // Arrange
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
            (_) async => http.Response('User created successfully', 201));

        // Act

        final methodCall = remoteDataSource.createUser;

        // Assert
        expect(
            methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
            completes);
        verify(
          () => client.post(
            Uri.https("${Constants.baseUrl}${Constants.createUserEndpoint}"),
            body: jsonEncode(
              {
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      });

      test(
          'should throw an [ApiException] when the status code '
          'is not 200 or 201', () async {
        // Arrange

        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
            (_) async => http.Response('Invalid email address', 400));

        // Act
        final methodCall = remoteDataSource.createUser;

        // Assert
        expect(
          methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          throwsA(
            const ApiException(
              message: 'Invalid email address',
              statusCode: 400,
            ),
          ),
        );
        verify(
          () => client.post(
            Uri.https("${Constants.baseUrl}${Constants.createUserEndpoint}"),
            body: jsonEncode(
              {
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      });
    },
  );

  group('getUser', () {
    final tUsers = [UserModel.empty()];
    test(
      'should return [List<User>] when the status code is 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response((jsonEncode([tUsers.first.toMap()])), 200),
        );

        // Act
        final result = await remoteDataSource.getUsers();

        // Assert
        expect(result, equals(tUsers));

        verify(() => client.get(
            Uri.https(Constants.baseUrl, Constants.getUserEndpoint))).called(1);
        verifyNoMoreInteractions(client);
      },
    );
    test(
      'should throw [ApiException] when the status code is not 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response('Something went wrong', 400),
        );

        // Act
        final methodCall = remoteDataSource.getUsers;

        // Assert
        expect(
          methodCall(),
          throwsA(
            const ApiException(
                message: 'Something went wrong', statusCode: 400),
          ),
        );

        verify(() => client.get(
            Uri.https(Constants.baseUrl, Constants.getUserEndpoint))).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
