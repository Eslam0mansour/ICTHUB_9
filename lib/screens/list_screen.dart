import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthubx/cubit/app_cubit.dart';
import 'package:icthubx/cubit/app_state.dart';
import 'package:icthubx/screens/login_screen.dart';
import 'package:icthubx/screens/product_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252837),
        title: const Text('Croma'),
        leading: InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              });
            },
            child: const Icon(
              Icons.logout,
            )),
        actions: [
          SvgPicture.asset(
            'images/bb.svg',
          ),
          IconButton(
            onPressed: () async {
              // setState(() {
              //   isLoading = true;
              // });
              // await context.read<AppCubit>().getData().then((value) {
              //   context.read<AppCubit>().myList = value;
              //   setState(() {
              //     isLoading = false;
              //   });
              // });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
        leadingWidth: 20,
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is GetProductsError) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.error,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<AppCubit>().getProductsData();
                        },
                        child: const Text('retray'),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is GetProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetProductsError) {
            return Center(
              child: Text(
                state.error,
              ),
            );
          } else if (state is GetProductsDone) {
            return SafeArea(
              child: GridView.builder(
                itemCount: context.read<AppCubit>().myList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            dataK: context.read<AppCubit>().myList[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: Image.network(
                            context.read<AppCubit>().myList[index].image,
                          ).image,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                context.read<AppCubit>().myList[index].name,
                              ),
                            ),
                            Text(
                              '${context.read<AppCubit>().myList[index].price.toString()} EGP',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            );
          } else {
            return const Center(child: Text('errorrrrrr'));
          }
        },
      ),
    );
  }
}
