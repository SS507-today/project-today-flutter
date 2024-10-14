import 'dart:convert';
import 'package:http/http.dart' as http;

/// [[[ API와 통신을 담당하는 서비스 클래스 ]]]
/// 기본적인 HTTP 요청(`GET`, `POST`, `PUT`, `DELETE`) 메서드를 제공
class ApiService {
  /// 서버의 기본 URL 주소
  /// TODO: 우리 서버 주소로 바꾸고 환경변수 처리
  final String baseUrl = 'http://3.36.115.177:8081';

  /// [ApiService] 클래스의 싱글턴 인스턴스를 생성
  static final ApiService _instance = ApiService._internal();

  /// 외부에서 인스턴스를 생성할 때 사용할 팩토리 생성자
  factory ApiService() => _instance;

  /// 내부에서 사용할 private 생성자
  ApiService._internal();

  /// 기본 공통 헤더 설정
  Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'accept': '*/*',
    //  'Accept': 'application/json',
  };

  /// [[[ GET 요청을 보내는 API 호출 함수 ]]]
  ///
  /// @param [String] endpoint - API의 엔드포인트 경로 지정
  /// @param [Map<String, String>?] headers - 요청에 추가할 헤더 정보 (옵션).
  /// @param [Map<String, String>?] queryParams - 요청 시 사용할 쿼리 파라미터 (옵션).
  /// @param [String?] accessToken - 인증을 위한 액세스 토큰 (옵션).
  ///
  /// @return [http.Response] 서버로부터의 응답 반환
  ///
  /// @throws Exception - HTTP 응답 상태가 200번대가 아닌 경우 예외 발생
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    String? accessToken,
    bool excludeContentType = false,
  }) async {
    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final combinedHeaders = _createHeaders(headers, accessToken);

    // excludeContentType 플래그가 true인 경우 Content-Type 제거
    if (excludeContentType) {
      combinedHeaders.remove('Content-Type');
    }

    final response = await http.get(uri, headers: combinedHeaders);
    _handleResponse(response);
    return response;
  }

  /// [[[ POST 요청을 보내는 API 호출 함수 ]]]
  ///
  /// @param [String] endpoint - API의 엔드포인트 경로 지정
  /// @param [Map<String, String]?] headers - 요청에 추가할 헤더 정보 (옵션).
  /// @param [dynamic] body - 요청에 포함할 데이터 (옵션, JSON 인코딩 필요).
  /// @param [String?] accessToken - 인증을 위한 액세스 토큰 (옵션).
  ///
  /// @return [http.Response] 서버로부터의 응답 반환
  ///
  /// @throws Exception - HTTP 응답 상태가 200번대가 아닌 경우 예외 발생
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    String? accessToken,
    Map<String, String>? queryParams, // queryParams 추가
    bool excludeContentType = false,
  }) async {
    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final combinedHeaders = _createHeaders(headers, accessToken);

    // excludeContentType 플래그가 true인 경우 Content-Type 제거
    if (excludeContentType) {
      combinedHeaders.remove('Content-Type');
    }

    final response = await http.post(
      uri,
      headers: combinedHeaders,
      body: json.encode(body),
    );
    _handleResponse(response);
    return response;
  }

  /// [[[ PUT 요청을 보내는 API 호출 함수 ]]]
  ///
  /// @param [String] endpoint - API의 엔드포인트 경로 지정
  /// @param [Map<String, String]?] headers - 요청에 추가할 헤더 정보 (옵션).
  /// @param [dynamic] body - 요청에 포함할 데이터 (옵션, JSON 인코딩 필요).
  /// @param [String?] accessToken - 인증을 위한 액세스 토큰 (옵션).
  ///
  /// @return [http.Response] 서버로부터의 응답 반환
  ///
  /// @throws Exception - HTTP 응답 상태가 200번대가 아닌 경우 예외 발생
  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    String? accessToken,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final combinedHeaders = _createHeaders(headers, accessToken);
    final response = await http.put(
      uri,
      headers: combinedHeaders,
      body: json.encode(body),
    );
    _handleResponse(response);
    return response;
  }

  /// [[[ DELETE 요청을 보내는 API 호출 함수 ]]]
  ///
  /// @param [String] endpoint - API의 엔드포인트 경로 지정
  /// @param [Map<String, String]?] headers - 요청에 추가할 헤더 정보 (옵션).
  /// @param [Map<String, String]?] queryParams - 요청 시 사용할 쿼리 파라미터 (옵션).
  /// @param [String?] accessToken - 인증을 위한 액세스 토큰 (옵션).
  ///
  /// @return [http.Response] 서버로부터의 응답 반환
  ///
  /// @throws Exception - HTTP 응답 상태가 200번대가 아닌 경우 예외 발생
  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    String? accessToken,
  }) async {
    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    final combinedHeaders = _createHeaders(headers, accessToken);
    final response = await http.delete(uri, headers: combinedHeaders);
    _handleResponse(response);
    return response;
  }

  /// [[[ 공통 헤더를 생성하고, 옵션으로 추가한 헤더를 합쳐서 반환 ]]]
  ///
  /// @param [Map<String, String]?] headers - 사용자 정의 헤더 (옵션).
  /// @param [String?] accessToken - 인증을 위한 액세스 토큰 (옵션).
  ///
  /// @return [Map<String, String>] 최종적으로 사용할 헤더 정보 반환
  Map<String, String> _createHeaders(
    Map<String, String>? headers,
    String? accessToken,
  ) {
    final combinedHeaders = {..._headers, ...?headers};
    if (accessToken != null && accessToken.isNotEmpty) {
      combinedHeaders['Authorization'] = 'Bearer $accessToken';
    }
    print('>>> 요청 헤더: $combinedHeaders'); // 요청 헤더 출력

    return combinedHeaders;
  }

  /// [[[ 서버의 응답을 처리하여 에러 상태 검사 ]]]
  ///
  /// @return [http.Response] 서버로부터의 응답 반환
  ///
  /// @throws Exception - HTTP 응답 상태가 200번대가 아닌 경우 예외 발생
  void _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
          'Failed request: ${response.statusCode} - ${response.body}');
    }
  }

  /// [[[ 공통 헤더에 액세스 토큰 설정 ]]]
  ///
  /// @param [String] token - 설정할 액세스 토큰 값
  void setToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  /// [[[ 공통 헤더에서 액세스 토큰 제거 ]]]
  void clearToken() {
    _headers.remove('Authorization');
  }
}
