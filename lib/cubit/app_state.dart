abstract class AppState {}

class AppInitial extends AppState {}

class GetProductsLoading extends AppState {}

class GetProductsDone extends AppState {}

class GetProductsError extends AppState {
  final String error;

  GetProductsError({required this.error});
}
