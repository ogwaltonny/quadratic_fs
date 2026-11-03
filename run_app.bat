@echo off
title Quadratic Financial Services
echo Starting Quadratic Financial Services Server...
start http://localhost:8080
"C:\flutter\bin\cache\dart-sdk\bin\dart.exe" web_server.dart
pause
