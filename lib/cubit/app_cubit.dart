import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/cubit/app_state.dart';
import 'package:icthubx/data/models/product_model.dart';

class ListOfProductsCubit extends Cubit<ListOfProductsState> {
  ListOfProductsCubit() : super(ListOfProductsInitial());

  List<ProductData> myList = [];
  List<ProductData> myListSearch = [];

  void searchForProducts(
    String search,
  ) {
    myListSearch.clear();
    myListSearch.addAll(
      myList.where((element) {
        return element.name.toLowerCase().contains(search.toLowerCase());
      }),
    );
    emit(GetProductsDone());
  }

  Future<void> getProductsData() async {
    try {
      emit(GetProductsLoading());
      QuerySnapshot<Map<String, dynamic>> dataP =
          await FirebaseFirestore.instance.collection('products').get();

      for (var item in dataP.docs) {
        ProductData object1 = ProductData.formDocs(item);
        myList.add(object1);
      }
      emit(GetProductsDone());
    } catch (e) {
      emit(GetProductsError(error: e.toString()));
    }
  }
}
