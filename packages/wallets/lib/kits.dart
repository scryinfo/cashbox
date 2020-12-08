import 'dart:ffi';

abstract class DC<C extends NativeType>{
  Pointer<C> toC();
  // static free<C extends NativeType>(Pointer<C> c);
}