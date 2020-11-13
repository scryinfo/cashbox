
#Setlocal
set buildFile=build_aarch64-linux-android.bat
set cuPath=%cd
set batPath=%~dp0
set outPath=%batPath%dl/arm64-v8a

call %batPath%/../cdl/script/%buildFile%
cd %batPath%../target/aarch64-linux-android/release
copy /Y "libcdl.so" "%outPath%"

cd %batPath%/../orm_rustorm
call %batPath%/../script/%buildFile%cd
cd %batPath%../orm_rustorm/target/aarch64-linux-android/release
copy /Y "liborm_rustorm.so" "%outPath%"

cd %batPath%/../orm_rbatis
call %batPath%/../script/%buildFile%
cd %batPath%../orm_rbatis/target/aarch64-linux-android/release/
copy /Y "liborm_rbatis.so" "%outPath%"

cd %cuPath%
#EndLocal

