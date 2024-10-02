import 'package:dio/dio.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:echo/model/favorites/favorites_model.dart';
import 'package:echo/model/products/products_model.dart';
import 'package:echo/model/supplier_orders/supplier_orders_model.dart';
import 'package:echo/model/supplier_products/supplier_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/supplier_products/disable_size_model.dart';
import '../../model/suppliers_product_size/supplier_product_size_model.dart'
    as supplierProductSize;

class SupplierMarketCubit extends Cubit<SupplierMarketStates> {
  SupplierMarketCubit() : super(SupplierMarketInitial());

  static SupplierMarketCubit get(context) => BlocProvider.of(context);

  SupplierProductsModel? supplierProductsModel;

  getSupplierProducts() {
    emit(GetSupplierProductsLoadingState());
    DioHelper.getData(
      url: EndPoints.getSupplierProducts,
      sendAuthToken: true,
    ).then((value) async {
      if (value.statusCode == 200) {
        supplierProductsModel =
            await SupplierProductsModel.fromJson(value.data);
        emit(GetSupplierProductsSuccessState());
      } else {
        emit(GetSupplierProductsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSupplierProductsErrorState());
    });
  }

  SupplierOrdersModel? supplierOrdersModel;
  getSupplierOrders() {
    emit(GetSupplierOrdersLoadingState());
    DioHelper.getData(
      url: EndPoints.getSupplierOrders,
      sendAuthToken: true,
    ).then((value) async {
      if (value.statusCode == 200) {
        supplierOrdersModel = await SupplierOrdersModel.fromJson(value.data);
        emit(GetSupplierOrdersSuccessState());
      } else {
        emit(GetSupplierOrdersErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSupplierOrdersErrorState());
    });
  }

  addProductToMarket({
    required int productId,
    required String from,
    required String to,
    required String minQuantity,
    String? minQuantity2,
    String? quantity2,
    String? quantity3,
    required String price1,
    String? price2,
    String? price3,
    required int? sizeId,
    // required List<int> colors,
  }) {
    emit(AddProductToMarketLoadingState());
    print(productId);
    print(sizeId);
    DioHelper.postData(
      // url: EndPoints.supplierAddProduct,
      url: EndPoints.supplierAddProductSize,
      sendAuthToken: true,
      data: {
        "product_id": productId,
        "from": from,
        "to": to,
        "min_quantity": minQuantity,
        if (minQuantity2 != "") "min_quantity2": minQuantity2,
        if (quantity2 != "") "quantity2": quantity2,
        if (quantity3 != "") "quantity3": quantity3,
        "price1": price1,
        if (price2 != "") "price2": price2,
        if (price3 != "") "price3": price3,
        "size_id": sizeId,
        // if (colors.isNotEmpty) "colors": colors,
      },
    ).then((value) async {
      print(value.data);
      print(value.statusCode);
      if (value.statusCode == 200) {
        emit(AddProductToMarketSuccessState(value.data["message"]));
      } else {
        toast(text: value.data["message"], color: Colors.red);
        emit(AddProductToMarketErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AddProductToMarketErrorState());
    });
  }

  supplierProductSize.SupplierProductsModel? supplierProductsModelForSize;

  void getSuppliersWithProductSize(
      {required int sizeId, required int productId}) async {
    emit(GetSuppliersWithProductSizeLoadingState());
    await DioHelper.postForm(
      url: EndPoints.getSuppliersForSpecificSize,
      data: FormData.fromMap(
        {
          "product_id": productId,
          'size_id': sizeId,
        },
      ),
    ).then((value) async {
      if (value.statusCode == 200) {
        supplierProductsModelForSize =
            await supplierProductSize.SupplierProductsModel.fromJson(
                value.data);
        supplierProductsModelForSize!.data!
            .removeWhere((element) => element.productSizes!.isEmpty);
        if (supplierProductsModelForSize!.data!.isEmpty) {
          notifyNoSuppliersForProductSize();
        } else {
          emit(GetSuppliersWithProductSizeSuccessState());
        }
      } else {
        emit(GetSuppliersWithProductSizeErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSuppliersWithProductSizeErrorState());
    });
  }

  void notifyNoSuppliersForProductSize() {
    emit(NoSuppliersForProductSize());
  }

  editProductFromMarket({
    required int supplierProductId,
    required String from,
    required String to,
    // required String minQuantity,
    // required String quantity2,
    // required String quantity3,
    // required String price1,
    // required String price2,
    // required String price3,
    // required int sizeId,
    // required int supplierProductSizeId,
    // required List<int> colors,
  }) {
    emit(EditProductFromMarketLoadingState());
    DioHelper.postData(
      url: EndPoints.supplierEditProduct,
      sendAuthToken: true,
      data: {
        "supplier_product_id": supplierProductId,
        "from": from,
        "to": to,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        emit(EditProductFromMarketSuccessState(value.data["message"]));
      } else {
        emit(EditProductFromMarketErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(EditProductFromMarketErrorState());
    });
  }

  addProductSizeToMarket({
    required int supplierProductId,
    required String minQuantity,
    required String quantity2,
    required String quantity3,
    required String price1,
    required String price2,
    required String price3,
    required int sizeId,
    required List<int> colors,
  }) {
    emit(AddProductSizeToMarketLoadingState());
    DioHelper.postData(
      url: EndPoints.supplierAddProductSize,
      sendAuthToken: true,
      data: {
        "supplier_product_id": supplierProductId,
        "min_quantity": minQuantity,
        "quantity2": quantity2,
        "quantity3": quantity3,
        "price1": price1,
        "price2": price2,
        "price3": price3,
        "size_id": sizeId,
        if (colors.isNotEmpty) "colors": colors,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        emit(AddProductSizeToMarketSuccessState(value.data["message"]));
      } else {
        emit(AddProductSizeToMarketErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AddProductSizeToMarketErrorState());
    });
  }

  editProductSizeFromMarket({
    required String supplierProductId,
    required String minQuantity,
    String? minQuantity2,
    required String quantity2,
    required String quantity3,
    required String price1,
    required String price2,
    required String price3,
    required String from,
    required String to,
    required int supplierProductSizeId,
    // required List<int> colors,
  }) {
    emit(EditProductSizeFromMarketLoadingState());
    print(supplierProductId);
    DioHelper.postData(
      url: EndPoints.supplierEditSizeProduct,
      sendAuthToken: true,
      data: {
        "supplier_product_id": supplierProductId,
        "min_quantity": minQuantity,
        if (minQuantity2 != "") "min_quantity2": minQuantity2,
        if (quantity2 != "") "quantity2": quantity2,
        if (quantity3 != "") "quantity3": quantity3,
        "price1": price1,
        if (price2 != "") "price2": price2,
        if (price3 != "") "price3": price3,
        "from": from,
        "to": to,
        "supplier_product_size_id": supplierProductSizeId,
        // if (colors.isNotEmpty) "colors": colors,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        emit(EditProductSizeFromMarketSuccessState(value.data["message"]));
      } else {
        toast(text: value.data["message"], color: Colors.red);
        emit(EditProductSizeFromMarketErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(EditProductSizeFromMarketErrorState());
    });
  }

  ProductsModel? productDetailsModel;
  DisableProductSize? disableProductSize;
  List<String> sizes = [];
  List<int> sizesIds = [];

  getProductDetails({
    required int productId,
  }) {
    sizes.clear();
    sizesIds.clear();
    emit(GetProductDetailsLoadingState());
    print(productId);
    DioHelper.postData(
      url: EndPoints.getProductDetails,
      sendAuthToken: true,
      data: {
        "product_id": productId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        productDetailsModel = ProductsModel.fromJson(value.data);
        //Fayez Stoped this

        // if (productDetailsModel!.data![0].productSizes!.isNotEmpty) {
        //   for (int i = 0;
        //       i < productDetailsModel!.data![0].productSizes!.length;
        //       i++) {
        //     sizes.add(
        //         productDetailsModel!.data![0].productSizes![i].sizes!.size!);
        //     sizesIds
        //         .add(productDetailsModel!.data![0].productSizes![i].sizes!.id!);
        //   }
        // }
        // if (productDetailsModel!.data![0].productColors!.isNotEmpty) {
        //   for (int i = 0; i < productDetailsModel!.data![0].productColors!.length; i++) {
        //     colors.add(productDetailsModel!.data![0].productColors![i].colors!.name!);
        //     colorsIds.add(productDetailsModel!.data![0].productColors![i].colors!.id!);
        //   }
        // }
        emit(GetProductDetailsSuccessState());
      } else {
        emit(GetProductDetailsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetProductDetailsErrorState());
    });
  }

  disableSize({
    required int sizeId,
  }) {
    emit(DiableProductSizeLoadingState());
    DioHelper.postData(
      url: EndPoints.disableProductSize,
      sendAuthToken: true,
      data: {
        "id": sizeId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        disableProductSize = DisableProductSize.fromJson(value.data);
        //Fayez Stoped this

        // if (productDetailsModel!.data![0].productSizes!.isNotEmpty) {
        //   for (int i = 0;
        //       i < productDetailsModel!.data![0].productSizes!.length;
        //       i++) {
        //     sizes.add(
        //         productDetailsModel!.data![0].productSizes![i].sizes!.size!);
        //     sizesIds
        //         .add(productDetailsModel!.data![0].productSizes![i].sizes!.id!);
        //   }
        // }
        // if (productDetailsModel!.data![0].productColors!.isNotEmpty) {
        //   for (int i = 0; i < productDetailsModel!.data![0].productColors!.length; i++) {
        //     colors.add(productDetailsModel!.data![0].productColors![i].colors!.name!);
        //     colorsIds.add(productDetailsModel!.data![0].productColors![i].colors!.id!);
        //   }
        // }
        emit(DiableProductSizeSuccessState());
      } else {
        emit(DiableProductSizeErrorState(
            "SomeThing Went Error Try Again Later!"));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(DiableProductSizeErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  getFavorites() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      url: EndPoints.getSupplierFavorites,
      sendAuthToken: true,
    ).then((value) async {
      if (value.statusCode == 200) {
        favoritesModel = await FavoritesModel.fromJson(value.data);
        emit(GetFavoritesSuccessState());
      } else {
        emit(GetFavoritesErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetFavoritesErrorState());
    });
  }

  addAndRemoveFavorites({
    required int productId,
  }) {
    emit(AddToFavoritesLoadingState());
    DioHelper.postData(
      url: EndPoints.addSupplierFavorites,
      sendAuthToken: true,
      data: {
        "product_id": productId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        getFavorites();
        toast(text: value.data["message"], color: Colors.green);

        emit(AddToFavoritesSuccessState(value.data["message"]));
      } else {
        emit(AddToFavoritesErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AddToFavoritesErrorState());
    });
  }
}
