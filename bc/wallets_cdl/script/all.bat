Setlocal
set cuPath=%cd%
set batPath=%~dp0

call "%batPath%/build_aarch64-linux-android.bat"
call "%batPath%/build_x86_64-linux-android.bat"
call "%batPath%/build_i686-linux-android.bat"
call "%batPath%/build_armv7-linux-androideabi.bat"

cd "%cuPath%"
EndLocal
