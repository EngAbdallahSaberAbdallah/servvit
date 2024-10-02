import '../../../../model/profile/profile_model.dart';
import 'cache_helper.dart';

class CacheKeysManger {
  static String getLanguageFromCache() =>
      CacheHelper.getData(key: 'lang') ?? 'ar';

  static String? getUserTokenFromCache() =>
      CacheHelper.getData(key: 'userToken') ?? "";

  static String? getUserTypeFromCache() =>
      CacheHelper.getData(key: 'type') ?? "";

  static void addToRemoveFromFavorites(int id) async {
    var list = getFavorites();
    if (list.contains(id.toString())) {
      list.remove(id.toString());
    } else {
      list.add(id.toString());
    }
    await CacheHelper.saveData(key: 'favorites', value: list);
  }

  static List<String> getFavorites() {
    return CacheHelper.getListOFData(key: 'favorites') ?? [];
  }

  static void setFavoriteList(List<String> favoriteProducts) async {
    await CacheHelper.saveData(key: 'favorites', value: favoriteProducts);
  }

  static void saveProfileData(ProfileModel profileData) async {
    await CacheHelper.saveData(key: 'profile', value: profileData.toRawJson());
  }

  static String? getProfileDataFromShared() {
    return CacheHelper.getData(key: 'profile') as String?;
  }
}
