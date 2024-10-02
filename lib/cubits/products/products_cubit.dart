import 'dart:io';

import 'package:dio/dio.dart';
import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import 'package:echo/model/products/products_model.dart';
import 'package:echo/model/products/vendor_product_model.dart'
    as vendorProductModel;
import 'package:echo/model/search/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/services/local/cache_helper/cache_keys.dart';
import '../../core/utils/constants.dart';
import '../../model/custom_product/custom_product.dart';
import '../../model/products/product_sizes.dart';
import '../../model/suppliers_product_size/supplier_product_size_model.dart';

part 'products_states.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);

  List<String> banners = [];

  ProductSizesModel? productSizesModel;
  getSupplierProductSizes({
    required int productId,
  }) {
    emit(GetProductSizesLoadingState());
    DioHelper.postData(
      url: EndPoints.getProductsSizes,
      data: {
        "product_id": productId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        print(value.data);
        productSizesModel = await ProductSizesModel.fromJson(value.data);
        emit(GetProductSizesSuccessState());
      } else {
        emit(GetProductSizesErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetProductSizesErrorState());
    });
  }

  vendorProductModel.ProductModel? allProductsModelP;
  int? clickedIndex;
  ProductsModel? productsModel;

  String? selectedSize;
  void selectProductSize(String size) {
    selectedSize = size;
    emit(SelectProductSizeState(size));
  }

  List<Sizes> productSizes = [];
  String? otherSize;

  void getProductSizes(int productId) async {
    emit(GetSizesOfProductLoadingState());
    try {
      await DioHelper.postForm(
        url: EndPoints.getSizesForProduct,
        data: FormData.fromMap(
          {
            'product_id': productId,
          },
        ),
      ).then((response) {
        if (response.statusCode == 200) {
          print(response.data);
          otherSize = response.data['data'][0]['other_size'].toString();
          productSizes.clear();
          (response.data['data'][0]['product_sizes'] as List)
              .forEach((element) {
            productSizes.add(Sizes.fromJson(element));
          });
          // if (response.data['data'][0]['other_size'] == 'yes') {
          //   productSizes.add(Sizes(id: -1, size: 'other'));
          // }
          emit(GetSizesOfProductSuccessState());
        } else {
          emit(GetSizesOfProductFailureState(response.statusMessage!));
        }
      });
    } catch (e) {
      emit(GetSizesOfProductFailureState(e.toString()));
      rethrow;
    }
  }

  void releaseProductSize() {
    emit(ReleaseSelectedProductSizeState());
  }

  //! add/remove favorite
  void addToRemoveFromFavorites(int productId) async {
    emit(AddRemoveFavoriteLoadingState());
    try {
      await DioHelper.postForm(
        url: EndPoints.addRemoveUserFavorite,
        sendAuthToken: true,
        data: FormData.fromMap(
          {"product_id": productId},
        ),
      ).then((response) {
        if (response.statusCode == 200) {
          CacheKeysManger.addToRemoveFromFavorites(productId);
          emit(AddRemoveFavoriteSuccessState(response.data['message']));
        } else {
          emit(AddRemoveFavoriteFailureState(response.statusMessage!));
        }
      });
    } catch (e) {
      emit(AddRemoveFavoriteFailureState(e.toString()));
      rethrow;
    }
  }

  // List<FavoriteProductModel> favoriteProducts = [];
  List<vendorProductModel.Data> favoriteProducts = [];
  void getFavoriteProducts() async {
    emit(GetFavoriteProductsLoadingState());
    try {
      await DioHelper.getData(
        url: EndPoints.getFavoriteProducts,
        sendAuthToken: true,
      ).then((response) {
        if (response.statusCode == 200) {
          favoriteProducts.clear();
          (response.data['data'] as List).forEach((element) {
            favoriteProducts
                .add(vendorProductModel.Data.fromJson(element['product']));
          });
          emit(GetFavoriteProductsSuccessState());
        } else {
          emit(GetFavoriteProductsFailureState(response.statusMessage!));
        }
      });
    } catch (e) {
      emit(GetFavoriteProductsFailureState(e.toString()));
      rethrow;
    }
  }

  getProductsByCategoryId({
    required int categoryId,
  }) {
    emit(GetAllProductsByCategoryIdLoadingState());
    DioHelper.postData(
      url: EndPoints.getProductsByCategoryId,
      data: {
        "category_id": categoryId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        print(value.data);
        productsModel = await ProductsModel.fromJson(value.data);
        allProductsModelP =
            await vendorProductModel.ProductModel.fromJson(value.data);
        emit(GetAllProductsByCategoryIdSuccessState());
      } else {
        emit(GetAllProductsByCategoryIdErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllProductsByCategoryIdErrorState());
    });
  }

  SearchModel? searchModel;
  BuildContext? context;
  void getSample(int supplierProductSizeId, BuildContext context) async {
    this.context = context;
    emit(GetSampleLoadingState());
    try {
      await DioHelper.postForm(
        url: EndPoints.addSample,
        data: FormData.fromMap(
          {
            'supplier_product_size_id': supplierProductSizeId,
          },
        ),
        sendAuthToken: true,
      ).then((response) {
        if (response.statusCode == 200) {
          VendorAddToCartCubit.get(context).cartCount();
          emit(GetSampleSuccessState(message: response.data['message']));
        } else if (response.statusCode == 422) {
          emit(GetSampleFailureState(response.data['message']));
        } else {
          emit(GetSampleFailureState(response.statusMessage!));
        }
      });
    } catch (e) {
      emit(GetSampleFailureState(e.toString()));
      rethrow;
    }
  }

  search({
    required String product,
  }) {
    emit(GetSearchDataLoadingState());
    DioHelper.postForm(
      url: EndPoints.search,
      data: FormData.fromMap(
        {
          "name": product,
        },
      ),
    ).then((value) async {
      if (value.statusCode == 200) {
        searchModel = await SearchModel.fromJson(value.data);
        emit(GetSearchDataSuccessState());
      } else {
        emit(GetSearchDataErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetSearchDataErrorState());
    });
  }

  final picker = ImagePicker();

  Future<void> pickImage(File? image) async {
    // emit(UploadImageLoadingState());
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(UploadImageSuccessState(image: image));
    }
  }

  List<String> images = [];
  List<String> files = [];
  Future<void> pickMultipleImages() async {
    List<XFile> filesPicked = await picker.pickMultipleMedia();
    for (var file in filesPicked) {
      if (file.path.endsWith('.jpg') ||
          file.path.endsWith('.jpeg') ||
          file.path.endsWith('.png') ||
          file.path.endsWith('.gif') ||
          file.path.endsWith('.bmp')) {
        images.add(file.path);
      } else {
        files.add(file.path);
      }
    }
    // images = await pickMultiImagesFromGallery();
    if (images.isNotEmpty || files.isNotEmpty) {
      // if (files.isNotEmpty)
      emit(UploadMultipleImagesSuccessState(images: images, files: files));
    }
  }

  CustomProductModel? customProductModel;
  sendCustomProduct({
    required String size,
    required String dimension,
    required String shape,
    required String color,
    required String quantity,
    required String category_id,
    required String is_other,
    required String other_type,
    required List<MultipartFile> images,
    required List<MultipartFile> files,
    String? description,
  }) {
    emit(SendCustomProductLoadingState());
    DioHelper.postData(
      url: EndPoints.sendCustomProduct,
      sendAuthToken: true,
      data: FormData.fromMap({
        "size": size,
        "dimension": dimension,
        if (shape.isNotEmpty) "shape": shape,
        if (shape.isNotEmpty) "color": color,
        "quantity": quantity,
        "category_id": category_id,
        "is_other": is_other,
        if (shape.isNotEmpty) "other_type": other_type,
        "description": description,
        "image[]": images,
        "file[]": files,
      }),
    ).then((value) async {
      if (value.statusCode == 200) {
        customProductModel = CustomProductModel.fromJson(value.data);
        CacheHelper.saveData(
          key: "isOrderPriceOpend",
          value: false,
        );
        images.clear();
        files.clear();
        emit(SendCustomProductSuccessState());
      } else {
        emit(SendCustomProductErrorState("Server Error"));
      }
    }).catchError((error) {
      emit(SendCustomProductErrorState(error.toString()));
    });
  }
}
