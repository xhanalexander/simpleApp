import 'package:simpleapp/model/user_model.dart';
import '../../constant/constant.dart';
import 'package:dio/dio.dart';

class UserAPI {
  static const String url = baseURL;

  Future<List<Data>> getUser({required pages, required perPages}) async {
  final dio = Dio();
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        queryParameters: {
          'page': pages,
          'per_page': perPages,
        },
      );

      // debugPrint('response results = $response');

      if (response.statusCode == 200) {
        final datas = response.data['data'];
        // debugPrint('datas = $datas');
        List<Data> listUser = List<Data>.from(datas.map((i) => Data.fromJson(i)));
        return listUser;
      } else {
        throw Exception('Failed to load user data...');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}