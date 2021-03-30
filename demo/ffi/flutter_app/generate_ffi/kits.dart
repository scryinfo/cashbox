import 'dart:ffi';
import 'dart:io';

import 'package:path/path.dart' as pathLib;

String _platformPath(String name, {String? path}) {
  if (path == null) path = "";
  String dlPath = "";
  if (Platform.isAndroid) {
    dlPath = pathLib.join(path, "lib" + name + ".so");
  } else if (Platform.isLinux) {
    dlPath = pathLib.join(path, "lib" + name + ".so");
    if (!(File(dlPath).existsSync())) {
      dlPath = Platform.script.resolve(dlPath).path;
    }
  } else if (Platform.isMacOS) {
    dlPath = pathLib.join(path, "lib" + name + ".dylib");
  } else if (Platform.isWindows) {
    if (!(File(dlPath).existsSync())) {
      dlPath = Platform.script.resolve(dlPath).path;
    }
    dlPath = pathLib.join(path, name + ".dll");
  } else {
    throw Exception("Platform not implemented");
  }

  return dlPath;
}

DynamicLibrary dlOpenPlatformSpecific(String name, {String? path}) {
  String fullPath = _platformPath(name, path: path);
  return DynamicLibrary.open(fullPath);
}


