part of 'all_products_cubit.dart';

abstract class AllProductsStates {}

class AllProductsInitial extends AllProductsStates {}



// get all products
class GetAllProductsLoadingState extends AllProductsStates {}

class GetAllProductsSuccessState extends AllProductsStates {}

class GetAllProductsErrorState extends AllProductsStates {}
