
Setlocal
@echo on
set batPath=%~dp0
%~d0
cd "%batPath%"

protoc --go_out=plugins=grpc:./greeter_go greeter.proto
cd ./greeter_go/ & go build

EndLocal
