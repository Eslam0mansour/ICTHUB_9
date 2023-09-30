import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/colors.dart';
import 'package:icthubx/cubit/app_cubit.dart';
import 'package:icthubx/cubit/app_state.dart';
import 'package:icthubx/widgets/mtTextFormField.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: BlocBuilder<ListOfProductsCubit, ListOfProductsState>(
            builder: (context, state) {
              return Column(
                children: [
                  MyFormFiled(
                    controller: searchC,
                    hintText: 'search',
                    onChanged: (s) {
                      context.read<ListOfProductsCubit>().searchForProducts(s);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: context
                          .read<ListOfProductsCubit>()
                          .myListSearch
                          .length,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context
                                        .read<ListOfProductsCubit>()
                                        .myListSearch[index]
                                        .name,
                                    style: const TextStyle(
                                      color: AppColors.hintText,
                                    ),
                                  ),
                                  Text(
                                    '${context.read<ListOfProductsCubit>().myListSearch[index].price.toString()} EGP',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.network(
                                    context
                                        .read<ListOfProductsCubit>()
                                        .myListSearch[index]
                                        .image,
                                  ).image,
                                ),
                              ),
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.all(10),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
