import 'package:dio/dio.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../core/utils/constants.dart';
import 'dart:io';
part 'vendor_add_to_cart_state.dart';

class VendorAddToCartCubit extends Cubit<VendorAddToCartState> {
  VendorAddToCartCubit() : super(VendorAddToCartInitial());

  static VendorAddToCartCubit get(context) => BlocProvider.of(context);

  String selectedDesignStatus = '';
  void addToCart({required String designStatus}) {
    selectedDesignStatus = designStatus;
    emit(VendorSelectedDesign());
  }

  String? selectedImage;
  void selectImage() async {
    await pickImageFromGallery().then((value) => selectedImage = value);
    emit(VendorSelectImage());
  }

  void uploadOrderToCart(
      {required int supplierId,
      required int quantity,
      required BuildContext context}) async {
    var images = ProductsCubit.get(context).images;
    var files = ProductsCubit.get(context).files;
    // if (images.isNotEmpty || files.isNotEmpty) {
    List<MultipartFile> mutipleImages = await Future.wait(
      images.map(
        (file) async {
          if (await File(file).exists()) {
            return MultipartFile.fromFile(file, filename: file.split("/").last);
          } else {
            throw Exception("File not found: $file");
          }
        },
      ).toList(),
    );

    List<MultipartFile> mutipleFiles = await Future.wait(
      files.map(
        (file) async {
          if (await File(file).exists()) {
            return MultipartFile.fromFile(file, filename: file.split("/").last);
          } else {
            throw Exception("File not found: $file");
          }
        },
      ).toList(),
    );

    List<MultipartFile> imagesAndFiles = mutipleImages + mutipleFiles;

    emit(VendorLoadingAddToCart());
    try {
      await DioHelper.postForm(
        url: EndPoints.addToCart,
        data: FormData.fromMap(
          {
            'supplier_product_size_id': supplierId,
            'quantity': quantity,
            'design': selectedDesignStatus,
            if (selectedDesignStatus == 'with') 'design_image': imagesAndFiles,
            // if (selectedDesignStatus == 'with') 'design_file': mutipleFiles,
          },
        ),
        sendAuthToken: true,
      ).then((response) {
        print(response.data);
        if (response.statusCode == 200) {
          emit(VendorSuccessAddToCart(response.data['message']));
        } else {
          emit(VendorErrorAddToCart('${response.data["message"]}'));
        }
      });
    } catch (e) {
      emit(VendorErrorAddToCart(e.toString()));
      rethrow;
    }
  }

  void cartCount() async {
    emit(CartCountLoadingState());
    try {
      await DioHelper.getData(url: EndPoints.cartCount, sendAuthToken: true)
          .then((response) {
        if (response.statusCode == 200) {
          emit(CartCountSuccessState(count: response.data['data']));
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
