library gen_dl.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/dc_generator.dart';

Builder dcBuilder(BuilderOptions options) =>
    LibraryBuilder(DCGenerator(), generatedExtension: '.dc.dart');
