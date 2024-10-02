abstract class SupplierMarketStates {}

class SupplierMarketInitial extends SupplierMarketStates {}

class GetSupplierProductsLoadingState extends SupplierMarketStates {}

class GetSupplierProductsSuccessState extends SupplierMarketStates {}

class GetSupplierProductsErrorState extends SupplierMarketStates {}
class DiableProductSizeLoadingState extends SupplierMarketStates {}
class DiableProductSizeSuccessState extends SupplierMarketStates {}
class DiableProductSizeErrorState extends SupplierMarketStates {
  final String errMessage;
  DiableProductSizeErrorState(this.errMessage);
}

class AddProductToMarketLoadingState extends SupplierMarketStates {}

class AddProductToMarketSuccessState extends SupplierMarketStates {
  final String message;

  AddProductToMarketSuccessState(this.message);
}

class AddProductToMarketErrorState extends SupplierMarketStates {}

class EditProductFromMarketLoadingState extends SupplierMarketStates {}

class EditProductFromMarketSuccessState extends SupplierMarketStates {
  final String message;

  EditProductFromMarketSuccessState(this.message);
}

class EditProductFromMarketErrorState extends SupplierMarketStates {}

class EditProductSizeFromMarketLoadingState extends SupplierMarketStates {}

class EditProductSizeFromMarketSuccessState extends SupplierMarketStates {
  final String message;

  EditProductSizeFromMarketSuccessState(this.message);
}

class EditProductSizeFromMarketErrorState extends SupplierMarketStates {}

class AddProductSizeToMarketLoadingState extends SupplierMarketStates {}

class AddProductSizeToMarketSuccessState extends SupplierMarketStates {
  final String message;

  AddProductSizeToMarketSuccessState(this.message);
}

class AddProductSizeToMarketErrorState extends SupplierMarketStates {}

class GetProductDetailsLoadingState extends SupplierMarketStates {}

class GetProductDetailsSuccessState extends SupplierMarketStates {}

class GetProductDetailsErrorState extends SupplierMarketStates {}

class GetFavoritesLoadingState extends SupplierMarketStates {}

class GetFavoritesSuccessState extends SupplierMarketStates {}

class GetFavoritesErrorState extends SupplierMarketStates {}

class AddToFavoritesLoadingState extends SupplierMarketStates {}

class AddToFavoritesSuccessState extends SupplierMarketStates {
  final String message;

  AddToFavoritesSuccessState(this.message);
}

class AddToFavoritesErrorState extends SupplierMarketStates {}

class GetSupplierOrdersLoadingState extends SupplierMarketStates {}

class GetSupplierOrdersSuccessState extends SupplierMarketStates {}

class GetSupplierOrdersErrorState extends SupplierMarketStates {}
// supplier for certin product size
class GetSuppliersWithProductSizeLoadingState extends SupplierMarketStates {}

class GetSuppliersWithProductSizeSuccessState extends SupplierMarketStates {}

class GetSuppliersWithProductSizeErrorState extends SupplierMarketStates {}

// no supplier for certin product size
class NoSuppliersForProductSize extends SupplierMarketStates {}
