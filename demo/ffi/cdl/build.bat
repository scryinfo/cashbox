Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%"

cargo build
cd "%batPath%../target/debug"
copy /Y "cdl.dll" "%batPath%../flutter_app"

EndLocal
