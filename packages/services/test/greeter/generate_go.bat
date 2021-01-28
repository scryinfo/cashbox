
Setlocal
@echo on
set batPath=%~dp0
cd %batPath%
%~d0
cd %batPath%

protoc --go_out=plugins=grpc:./greeter_go greeter.proto
cd ./greeter_go/ & go build

cd %batPath%
EndLocal
