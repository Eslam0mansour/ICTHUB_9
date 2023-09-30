import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/cubit/profile_cubit.dart';
import 'package:icthubx/cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetUserDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetUserDataError) {
            return Center(
              child: Text(
                state.error,
              ),
            );
          } else if (state is GetUserDataDone) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      context.read<ProfileCubit>().userData!.email,
                    ),
                    leading: const Icon(
                      Icons.email,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      context.read<ProfileCubit>().userData!.name,
                    ),
                    leading: const Icon(
                      Icons.person,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      context.read<ProfileCubit>().userData!.phone,
                    ),
                    leading: const Icon(
                      Icons.phone,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      context.read<ProfileCubit>().userData!.pass,
                    ),
                    leading: const Icon(
                      Icons.password,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      context.read<ProfileCubit>().userData!.uid,
                    ),
                    leading: const Icon(
                      Icons.access_alarms_outlined,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('errror');
          }
        },
      ),
    );
  }
}
