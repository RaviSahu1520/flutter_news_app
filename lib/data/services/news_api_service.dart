import 'package:dio/dio.dart';
import 'package:news_feed_app/core/constants.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService()
      : dio = Dio(BaseOptions(
    baseUrl: AppStrings.newsApiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'X-Api-Key': AppStrings.newsApiKey},
  )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add logging here if needed
        return handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (DioException e, handler) async {
        // Retry mechanism
        if (_shouldRetry(e)) {
          try {
            final opts = e.requestOptions;
            final cloneReq = await dio.request(opts.path,
                options: Options(
                  method: opts.method,
                  headers: opts.headers,
                ),
                data: opts.data,
                queryParameters: opts.queryParameters);
            return handler.resolve(cloneReq);
          } catch (err) {
            return handler.next(e);
          }
        }
        return handler.next(e);
      },
    ));
  }

  Future<Map<String, dynamic>> fetchNews({
    required String query,
    required int page,
    String sortBy = 'publishedAt',
    int pageSize = AppStrings.articlesPerPage,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      '/everything',
      queryParameters: {
        'q': query,
        'sortBy': sortBy,
        'pageSize': pageSize,
        'page': page,
        'language': 'en',
      },
      cancelToken: cancelToken,
    );
    return response.data;
  }

  bool _shouldRetry(DioException e) =>
      e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout;
}