abstract class ListOfProductsState {}

class ListOfProductsInitial extends ListOfProductsState {}

class GetProductsLoading extends ListOfProductsState {}

class GetProductsDone extends ListOfProductsState {}

class GetProductsError extends ListOfProductsState {
  final String error;

  GetProductsError({required this.error});
}
