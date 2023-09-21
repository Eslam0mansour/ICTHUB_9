import 'package:flutter/material.dart';
import 'package:icthubx/data/data_source/products_data_source.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (DataSource.userData == null) {
      Future.delayed(
        Duration.zero,
        () async {
          var data = await DataSource.getUserDataFromFireStore();
          setState(() {
            DataSource.userData = data;
            isLoading = false;
          });
        },
      );
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      DataSource.userData!.email,
                    ),
                    leading: const Icon(
                      Icons.email,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      DataSource.userData!.name,
                    ),
                    leading: const Icon(
                      Icons.person,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      DataSource.userData!.phone,
                    ),
                    leading: const Icon(
                      Icons.phone,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      DataSource.userData!.pass,
                    ),
                    leading: const Icon(
                      Icons.password,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      DataSource.userData!.uid,
                    ),
                    leading: const Icon(
                      Icons.access_alarms_outlined,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
