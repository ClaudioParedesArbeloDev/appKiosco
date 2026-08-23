import 'package:dio/dio.dart';
import 'api_base_url.dart';

class ApiClient {
  ApiClient() : dio = Dio(BaseOptions(
          baseUrl: ApiBaseUrl.value,
          headers: {'Accept': 'application/json'},
          // Sin esto, una request a un server inalcanzable (IP/puerto mal
          // configurado, servidor caído) se queda esperando el timeout del
          // sistema operativo, que puede ser de más de un minuto — el
          // splash screen quedaba colgado por esto.
          connectTimeout: const Duration(seconds: 8),
          receiveTimeout: const Duration(seconds: 15),
        ));

  final Dio dio;

  void setToken(String? token) {
    if (token == null) {
      dio.options.headers.remove('Authorization');
    } else {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
