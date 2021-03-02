
Setlocal
@echo on
set batPath=%~dp0
%~d0
cd "%batPath%"

protoc --dart_out=grpc:../client_dart/lib/src/generated greeter.proto

cd "%batPath%"
EndLocal
