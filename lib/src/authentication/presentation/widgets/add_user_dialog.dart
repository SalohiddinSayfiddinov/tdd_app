import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "User Name"),
                controller: nameController,
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();

                  if (name.isNotEmpty) {
                    context.read<AuthCubit>().createUser(
                        name: name,
                        surname: 'surname',
                        phone: 'phone',
                        password: 'password');
                    Navigator.pop(context);
                  }
                },
                child: const Text("Create user"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
