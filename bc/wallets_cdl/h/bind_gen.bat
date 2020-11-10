
set cuPath=%cd%
set batPath=%~dp0
cd %batPath%
cd ../src
set out=%cd%
cd %batPath%

set pre="#![allow(non_upper_case_globals)]#![allow(non_camel_case_types)]#![allow(non_snake_case)]#![allow(dead_code)]"
bindgen all.h -o %out%/wallets_c.rs --raw-line %pre%

cd %cuPath%

