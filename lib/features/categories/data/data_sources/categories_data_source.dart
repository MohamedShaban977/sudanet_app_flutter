import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/categories_response.dart';

abstract class CategoriesDataSource {
  Future<CollectionResponse<CategoriesResponse>> getAllCategories();
}

class CategoriesDataSourceImpl implements CategoriesDataSource {
  ApiConsumer apiConsumer;

  CategoriesDataSourceImpl({required this.apiConsumer});

  @override
  Future<CollectionResponse<CategoriesResponse>> getAllCategories() async {
    final response = await apiConsumer.get(EndPoint.getAllCategory);

    final res = CollectionResponse<CategoriesResponse>.fromJson(response,
        (list) => list.map((e) => CategoriesResponse.fromJson(e)).toList());

    return res;
  }
}
