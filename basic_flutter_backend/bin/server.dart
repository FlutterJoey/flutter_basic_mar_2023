import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/validate-key', _keyValidator)
  ..post('/login', _loginHandler)
  ..get('/characters', _getCharacterNames)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

const String apiKey = 'FlutterBasicTraining';

final Map<String, DateTime> apiKeys = {};

class ApiKey {
  final String key;
  final DateTime dateTime;
  ApiKey({
    required this.key,
    required this.dateTime,
  });
}

ApiKey _getApiKey() {
  String key = '${apiKeys.length}${apiKey}2023';
  var dateTime = DateTime.now().add(Duration(hours: 48));
  apiKeys[key] = dateTime;
  return ApiKey(key: key, dateTime: dateTime);
}

/// whether the provided [key] returns a valid key
bool _validateKey(String? key) {
  if (key == null) {
    return false;
  }
  var duration = apiKeys[key];
  if (duration == null) {
    return false;
  }
  return (DateTime.now().isBefore(duration));
}

Response _getCharacterNames(Request request) {
  var key = request.headers['X-API-Key'];
  if (_validateKey(key)) {
    return Response.ok(jsonEncode({
      'characters': [
        {'name': 'Jeroen', 'type': 'angry'},
        {'name': 'Arjan', 'type': 'funny'},
        {'name': 'John', 'type': 'scared'},
        {'name': 'Joey', 'type': 'loving'},
        {'name': 'Niels', 'type': 'neutral'},
        {'name': 'Thomas', 'type': 'angry'},
        {'name': 'Tim', 'type': 'angry'},
        {'name': 'Brighton', 'type': 'loving'},
        {'name': 'Joons', 'type': 'scared'},
        {'name': 'Tim the 2nd', 'type': 'scared'},
      ],
    }));
  } else {
    return Response.forbidden(jsonEncode({
      'error': 'invalid credentials provided',
    }));
  }
}

Response _keyValidator(Request request) {
  var key = request.headers['X-API-Key'];
  if (key == null) {
    return Response.badRequest();
  }
  if (!_validateKey(key)) {
    return Response.forbidden(jsonEncode({
      'error': 'invalid credentials provided',
    }));
  }
  return Response.ok(jsonEncode({'token': apiKey}));
}

Future<Response> _loginHandler(Request request) async {
  String body = await request.readAsString();
  try {
    var result = jsonDecode(body);
    String? username = result['username'];
    String? password = result['password'];

    if (username == null || password == null) {
      return Response.badRequest();
    }

    if (username.contains('@iconica') && password == 'test123') {
      var apiKey = _getApiKey();
      return Response.ok(jsonEncode({
        'token': apiKey.key,
        'valid_until': apiKey.dateTime.millisecondsSinceEpoch
      }));
    }

    return Response(401);
  } catch (_) {
    print(_);
    return Response.badRequest();
  }
}

const _defaultHeadersList = [
  'accept',
  'accept-encoding',
  'authorization',
  'content-type',
  'dnt',
  'origin',
  'user-agent',
  'x-api-key',
];

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(corsHeaders(headers: {
        ACCESS_CONTROL_ALLOW_HEADERS: _defaultHeadersList.join(','),
      }))
      .addMiddleware(logRequests())
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
