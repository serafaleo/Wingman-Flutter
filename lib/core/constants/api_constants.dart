import 'package:flutter/foundation.dart';

const _localhost = '10.0.2.2';

final class ApiConstants {
  static const baseUrl = kDebugMode ? 'https://$_localhost:44328/api/' : 'PRODUCTION URL HERE!!!';
}
