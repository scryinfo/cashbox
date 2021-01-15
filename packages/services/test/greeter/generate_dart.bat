
Setlocal
@echo on
set batPath=%~dp0
cd %batPath%
%~d0
cd %batPath%

protoc --dart_out=grpc:./ greeter.proto

cd %batPath%
EndLocal
