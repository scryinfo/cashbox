
Setlocal
@echo on
set batPath=%~dp0
cd %batPath%
%~d0
cd %batPath%
#--go_opt=paths=source_relative
protoc --go_out=plugins=grpc:../server_go greeter.proto
cd ../server_go/ & go build

cd %batPath%
EndLocal
