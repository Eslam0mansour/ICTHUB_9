import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/colors.dart';
import 'package:icthubx/cubit/app_cubit.dart';
import 'package:icthubx/cubit/profile_cubit.dart';
import 'package:icthubx/screens/list_screen.dart';
import 'package:icthubx/screens/profile_screen.dart';
import 'package:icthubx/screens/search.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> listScreens = [
    const ListScreen(),
    SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListOfProductsCubit>(
          create: (context) => ListOfProductsCubit()..getProductsData(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..getUserDataFromFireStore(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        body: listScreens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.scaffold,
          unselectedItemColor: AppColors.hintTextK,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}
