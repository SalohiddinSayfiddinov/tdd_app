import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_app/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_app/src/authentication/presentation/widgets/loading_column.dart';
import 'package:tdd_app/src/products/presentation/cubit/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  void getUsers() async {
    context.read<AuthCubit>().getUsers();
  }

  void getProducts() async {
    context.read<ProductsCubit>().getProductById(productId: '1');
  }

  @override
  void initState() {
    super.initState();
    // getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      }, builder: (context, state) {
        if (state is GettingUsers || state is CreatingUser) {
          return const LoadingColumn(message: 'Fetching users');
        } else if (state is UsersLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                ),
                title: Text(user.name),
                subtitle: Text(user.surname),
              );
            },
          );
        }
        return const SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getProducts();
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AddUserDialog(nameController: nameController);
          //   },
          // );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add User"),
      ),
    );
  }
}
