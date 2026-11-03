import 'dart:io';

void main() async {
  final buildDir = Directory('build/web');
  if (!await buildDir.exists()) {
    print('Error: build/web directory not found. Please build the web app first.');
    return;
  }

  final port = 8080;
  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  print('========================================================');
  print('  QUADRATIC FINANCIAL SERVICES - Web Server is RUNNING  ');
  print('========================================================');
  print('  Computer Local Access: http://localhost:$port');
  print('  Phone / Wi-Fi Access:  http://192.168.137.38:$port');
  print('========================================================');

  final mimeTypes = {
    'html': 'text/html; charset=utf-8',
    'js': 'application/javascript; charset=utf-8',
    'mjs': 'application/javascript; charset=utf-8',
    'css': 'text/css; charset=utf-8',
    'json': 'application/json; charset=utf-8',
    'wasm': 'application/wasm',
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'svg': 'image/svg+xml',
    'ttf': 'font/ttf',
    'otf': 'font/otf',
    'woff': 'font/woff',
    'woff2': 'font/woff2',
    'ico': 'image/x-icon',
  };

  await for (HttpRequest request in server) {
    try {
      request.response.headers.add('Access-Control-Allow-Origin', '*');
      request.response.headers.add('Cross-Origin-Embedder-Policy', 'credentialless');
      request.response.headers.add('Cross-Origin-Opener-Policy', 'same-origin');

      var reqPath = request.uri.path;
      if (reqPath == '/' || reqPath.isEmpty) reqPath = '/index.html';

      // Sanitization
      reqPath = reqPath.replaceAll('..', '');
      var filePath = '${buildDir.path}$reqPath';
      var file = File(filePath);

      if (!await file.exists()) {
        file = File('${buildDir.path}/index.html');
        reqPath = '/index.html';
      }

      final ext = reqPath.contains('.') ? reqPath.split('.').last.toLowerCase() : 'html';
      final mime = mimeTypes[ext] ?? 'application/octet-stream';
      request.response.headers.set(HttpHeaders.contentTypeHeader, mime);

      await file.openRead().pipe(request.response);
    } catch (e) {
      try {
        request.response.statusCode = HttpStatus.internalServerError;
        request.response.write('Server Error: $e');
        await request.response.close();
      } catch (_) {}
    }
  }
}
