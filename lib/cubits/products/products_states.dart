part of 'products_cubit.dart';

abstract class ProductsStates {}

class ProductsInitial extends ProductsStates {}

class GetProductSizesLoadingState extends ProductsStates {}

class GetProductSizesSuccessState extends ProductsStates {}

class GetProductSizesErrorState extends ProductsStates {}

class GetAllProductsByCategoryIdLoadingState extends ProductsStates {}

class GetAllProductsByCategoryIdSuccessState extends ProductsStates {}

class GetAllProductsByCategoryIdErrorState extends ProductsStates {}

class GetSupplierProductsLoadingState extends ProductsStates {}

class GetSupplierProductsSuccessState extends ProductsStates {}

class GetSupplierProductsErrorState extends ProductsStates {}

class GetSearchDataLoadingState extends ProductsStates {}

class GetSearchDataSuccessState extends ProductsStates {}

class GetSearchDataErrorState extends ProductsStates {}

// get all products

class SendCustomProductLoadingState extends ProductsStates {}

class SendCustomProductSuccessState extends ProductsStates {}

class SendCustomProductErrorState extends ProductsStates {
  String error;
  SendCustomProductErrorState(this.error);
}

class UploadImageLoadingState extends ProductsStates {}

class UploadImageSuccessState extends ProductsStates {
  final File? image;
  UploadImageSuccessState({required this.image});
}

class UploadMultipleImagesSuccessState extends ProductsStates {
  final List<String> images;
  final List<String> files;
  UploadMultipleImagesSuccessState({this.images = const [], this.files = const []});
}

// select product size
class SelectProductSizeState extends ProductsStates {
  final String size;

  SelectProductSizeState(this.size);
}

// release selected product size
class ReleaseSelectedProductSizeState extends ProductsStates {}

// // get suppliers with product size
// class GetSuppliersWithProductSizeLoadingState extends ProductsStates {}

// class GetSuppliersWithProductSizeSuccessState extends ProductsStates {}

// class GetSuppliersWithProductSizeErrorState extends ProductsStates {}

class AddRemoveFavoriteLoadingState extends ProductsStates {}

class AddRemoveFavoriteSuccessState extends ProductsStates {
  final String message;
  AddRemoveFavoriteSuccessState(this.message);
}

class AddRemoveFavoriteFailureState extends ProductsStates {
  final String errorMessage;
  AddRemoveFavoriteFailureState(this.errorMessage);
}

class GetSizesOfProductLoadingState extends ProductsStates {}

class GetSizesOfProductSuccessState extends ProductsStates {}

class GetSizesOfProductFailureState extends ProductsStates {
  final String errorMessage;
  GetSizesOfProductFailureState(this.errorMessage);
}

class GetFavoriteProductsLoadingState extends ProductsStates {}

class GetFavoriteProductsSuccessState extends ProductsStates {}

class GetFavoriteProductsFailureState extends ProductsStates {
  final String errorMessage;
  GetFavoriteProductsFailureState(this.errorMessage);
}

class GetSampleLoadingState extends ProductsStates {}

class GetSampleSuccessState extends ProductsStates {
  final String message;

  GetSampleSuccessState({required this.message});
}

class GetSampleFailureState extends ProductsStates {
  final String errorMessage;
  GetSampleFailureState(this.errorMessage);
}
