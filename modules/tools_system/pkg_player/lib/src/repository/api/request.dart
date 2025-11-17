import 'package:unit_env/unit_env.dart';

import '../model/model.dart';

class PackageRequest with ScienceHostMixin {
  Future<ApiRet<dynamic>> getAllPackages() async {
    return host.get(PkgUrl.listPackages.path, convertor: (e) => e);
  }

  Future<ApiRet<dynamic>> insertPackage(Map<String, dynamic> data) async {
    return host.post('/packages/import', data: data);
  }

  Future<ApiRet<dynamic>> deletePackages(String name) async {
    return host.delete('/packages/$name');
  }

  Future<ApiRet<dynamic>> addCategories({
    required String key,
    required String name,
    required String? desc,
  }) async {
    return addCategoriesRaw({
      'key': key,
      'name': name,
      'description': desc ?? '',
    });
  }

  Future<ApiRet<List<PluginModel>>> getCategoriesPackage({
    required String key,
  }) async {
    return host.get('/categories/$key/export', queryParameters: {
      'sort_by': 'downloads',
    }, convertor: (data) {
      List<dynamic> list = data['data'] as List<dynamic>;
      return list.map((json) => PluginModel.fromJson(json)).toList();
    });
  }

  Future<ApiRet<dynamic>> addCategoriesRaw(Map<String, dynamic> data) async {
    return host.post('/categories', data: data);
  }

  Future<ApiRet<dynamic>> addToCategories(
    String categoryKey,
    List<String> packageNames,
  ) async {
    return host.post('/packages/add_to_category', data: {
      "category_key": categoryKey,
      "package_names": packageNames,
    });
  }

  Future<ApiRet<List<Category>>> getCategories() async {
    return host.get<List<Category>>('/categories', queryParameters: {
      'page': 1,
      'page_size': 100,
    }, convertor: (data) {
      List<dynamic> list = data['data'] as List<dynamic>;
      dynamic value =
          list.map<Category>((json) => Category.fromJson(json)).toList();
      return value;
    });
  }

  Future<void> insertPackages(String category, List<dynamic> jsonData) async {
    List<String> packageNames = [];
    for (dynamic data in jsonData) {
      print("insertPackages:${data['name']}");
      await insertPackage(data);
      packageNames.add(data['name']);
    }
    ApiRet<dynamic> ret = await addToCategories(category, packageNames);
    if (ret.success) {
      print(ret.data);
    }
  }
}

enum PkgUrl {
  listPackages("/packages"),
  ;

  final String path;
  final Method? method;

  const PkgUrl(this.path, [this.method = Method.get]);
}
