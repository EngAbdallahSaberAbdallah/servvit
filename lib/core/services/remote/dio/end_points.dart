class EndPoints {
  static const baseUrl = "https://dashboard.servvit.com/api/";
  // 'https://echo.monsq.com/api/';
  //echo-rose-eight.vercel.app

  /////////////////// Supplier Auth ////////////////////////
  static const supplierLogin = 'supplier/otplogin';
  static const supplierRegister = 'supplier/register';
  static const supplierLogout = 'supplier/logout';
  static const supplierProfileData = 'supplier/getSupplierData';
  static const supplierChangePassword = 'supplier/change_password';
  static const supplierUpdateProfile = 'supplier/edit';
  static const supplierCheckOtp = 'supplier/checkotp';
  static const supplierFcmToken = 'supplier/device_token';

  /////////////////// user Auth ////////////////////////
  static const userLogin = 'user/otplogin';
  static const userRegister = 'user/register';
  static const userLogout = 'user/logout';
  static const userProfileData = 'user/getUserData';
  static const userChangePassword = 'user/change_password';
  static const userUpdateProfile = 'user/edit';
  static const userCheckOtp = 'user/checkotp';
  static const userFcmToken = 'user/device_token';

  //////////////////// Device Token ////////////////////////////
  static const userDeviceToken = 'user/otplogin';

  /////////////////// Supplier Products ////////////////////////
  static const supplierAddProduct = 'add/product';
  static const supplierAddProductSize = 'add/product/size';
  static const sendTechnicalSupport = 'send/your/opinion';
  static const sendCustomProduct = 'customize/product';
  static const getAllDiscussions = 'get/discussions';
  static const getAllDesignRequests = 'user/pending/requests';
  static const sendReview = 'add/review';
  static const supplierEditProduct = 'edit/product';
  static const supplierEditSizeProduct = 'edit/product/size';
  static const getSupplierProducts = 'get/supplier/products';
  static const getSupplierOrders = 'get/supplier/orders';

  /////////////////////////// Home Url //////////////////////////////
  static const getBusinessTypes = 'get/all/business_types';
  static const getGovernorates = 'get/all/governorates';
  static const getBanners = 'banners/all';
  static const getAllCategories = 'get/all/categories';
  static const getAllProducts = 'get/all/products';
  static const getProductsByCategoryId = 'get/products/by/category';
  static const getProductsSizes = 'get/sizes/for/product';
  static const getProductDetails = "get/sizes/and/colors/for/product";
  static const disableProductSize = "disable/product/size";
  static const getSupplierFavorites = "get/supplier/favorite";
  static const addSupplierFavorites = "add/supplier/favorite";
  static const search = "search";
  static const echoFirendly = 'get/echo/friendly';
  static const getAllCustomers = 'get/customers';
  static const getAllCustomizeRequests = 'all/customized/product';
  static const getAllServices = 'get/services';
  static const getAllReviews = 'get/reviews';
  static const getAllCountries = 'get/all/governorates';
  static const getSuppliersForSpecificSize =
      "get/supplier/products/for/specific/product/size";
  static const searchSuggestions = 'dropdown/search';

  /////////////////////////// client profile //////////////////////////////
  static const getAllNotifications = 'get/client/notifications';
  static const getMyCart = 'get/my/cart';
  static const getMyAcceptedOrder = 'get/my/accepted/orders';
  static const AddToCartCustomizeRequests = 'accept/customized/product';
  static const AddToCartDesignedRequests = 'user/accept/price';
  static const rejectCustomizeRequests = 'reject/customized/product';
  static const rejectDesignedRequests = 'user/reject/price';
  static const cancelRequest = 'delete/customized/product';
  static const getMyPendingOrder = 'get/my/pending/orders';
  static const getMyRejectedOrder = 'get/my/rejected/orders';

  /////////////////////////// client products //////////////////////////////
  static const addToCart = 'add/to/cart';
  static const deleteFromCart = 'remove/from/cart';
  static const addRemoveUserFavorite = 'add/favorite';
  static const getSizesForProduct = 'get/sizes/for/product';
  static const getFavoriteProducts = 'get/my/favorite';
  static const addSample = 'add/sample';
  static const cartCount = 'get/my/cart/counter';
  /////////////////////////// Payment //////////////////////////////////
  static const getShippingCost = 'get/shipping/cost';
  static const pay = 'add/order';

  /////////////////////////// Settings //////////////////////////////////

  static const getContactUs = 'settings/contact-us';
  static const getAboutUs = 'settings/about-us';
  static const getFaqs = 'settings/faq';

  /////////////////////////// Images Urls //////////////////////////////

  static const banners = "https://dashboard.servvit.com/images/banners/";
  static const suppliers = "https://dashboard.servvit.com/images/suppliers/";
  static const categories = "https://dashboard.servvit.com/images/categories/";
  static const products = "https://dashboard.servvit.com/images/products/";
  static const customers =
      "https://dashboard.servvit.com/images/customer_images/";
  static const clients = "https://dashboard.servvit.com/images/clients/";
  static const services = "https://dashboard.servvit.com/images/services/";
  static const features = "https://dashboard.servvit.com/images/features/";
  static const public = "https://dashboard.servvit.com/images/product_designs/";
  static const customized =
      "https://dashboard.servvit.com/images/customized_products/";
  static const discussions =
      "https://dashboard.servvit.com/images/discussions/";

  /////////////////////////// Status Codes //////////////////////////////
  // 429 too many requests
  // 422 validation
  // 500 error
  // 404 not found
  // 401 unauthorized
  // 200 success
  static const List<int> successStatueCode = [200, 422, 500, 404, 401, 429];
}
