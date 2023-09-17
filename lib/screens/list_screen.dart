import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthubx/data/data_source/products_data_source.dart';
import 'package:icthubx/screens/login_screen.dart';
import 'package:icthubx/screens/product_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (DataSource.myList.isEmpty) {
      Future.delayed(
        Duration.zero,
        () async {
          var data = await DataSource.getData();
          setState(() {
            DataSource.myList = data;
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
              setState(() {
                isLoading = true;
              });
              await DataSource.getData().then((value) {
                DataSource.myList = value;
                setState(() {
                  isLoading = false;
                });
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
        leadingWidth: 20,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: GridView.builder(
                itemCount: DataSource.myList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            dataK: DataSource.myList[index],
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
                            DataSource.myList[index].image,
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
                                DataSource.myList[index].name,
                              ),
                            ),
                            Text(
                              '${DataSource.myList[index].price.toString()} EGP',
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
            ),
    );
  }
}
