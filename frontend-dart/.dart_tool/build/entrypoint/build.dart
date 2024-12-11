// Ensure that the build script itself is not opted in to null safety,
// instead of taking the language version from the current package.
//
// @dart=2.9
//
// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:source_gen/builder.dart' as _i2;
import 'package:build_web_compilers/builders.dart' as _i3;
import 'package:angular/src/build.dart' as _i4;
import 'package:build_test/builder.dart' as _i5;
import 'package:build_config/build_config.dart' as _i6;
import 'package:build_modules/builders.dart' as _i7;
import 'package:build/build.dart' as _i8;
import 'dart:isolate' as _i9;
import 'package:build_runner/build_runner.dart' as _i10;
import 'dart:io' as _i11;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'source_gen:combining_builder',
    [_i2.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.apply(
    r'build_web_compilers:sdk_js',
    [
      _i3.sdkJsCompileUnsound,
      _i3.sdkJsCompileSound,
      _i3.sdkJsCopyRequirejs,
    ],
    _i1.toNoneByDefault(),
    isOptional: true,
    hideOutput: true,
  ),
  _i1.apply(
    r'angular:angular',
    [
      _i4.templatePlaceholder,
      _i4.templateCompiler,
      _i4.stylesheetCompiler,
    ],
    _i1.toDependentsOf(r'angular'),
    isOptional: true,
    hideOutput: true,
    appliesBuilders: const [
      r'angular:placeholder_cleanup',
      r'angular:component_source_cleanup',
    ],
  ),
  _i1.apply(
    r'build_test:test_bootstrap',
    [
      _i5.debugIndexBuilder,
      _i5.debugTestBuilder,
      _i5.testBootstrapBuilder,
    ],
    _i1.toRoot(),
    hideOutput: true,
    defaultGenerateFor: const _i6.InputSet(include: [
      r'$package$',
      r'test/**',
    ]),
  ),
  _i1.apply(
    r'build_modules:module_library',
    [_i7.moduleLibraryBuilder],
    _i1.toAllPackages(),
    isOptional: true,
    hideOutput: true,
    appliesBuilders: const [r'build_modules:module_cleanup'],
  ),
  _i1.apply(
    r'build_web_compilers:dart2js_modules',
    [
      _i3.dart2jsMetaModuleBuilder,
      _i3.dart2jsMetaModuleCleanBuilder,
      _i3.dart2jsModuleBuilder,
    ],
    _i1.toNoneByDefault(),
    isOptional: true,
    hideOutput: true,
    appliesBuilders: const [r'build_modules:module_cleanup'],
  ),
  _i1.apply(
    r'build_web_compilers:ddc_modules',
    [
      _i3.ddcMetaModuleBuilder,
      _i3.ddcMetaModuleCleanBuilder,
      _i3.ddcModuleBuilder,
    ],
    _i1.toNoneByDefault(),
    isOptional: true,
    hideOutput: true,
    appliesBuilders: const [r'build_modules:module_cleanup'],
  ),
  _i1.apply(
    r'build_web_compilers:ddc',
    [
      _i3.ddcKernelBuilderUnsound,
      _i3.ddcBuilderUnsound,
      _i3.ddcKernelBuilderSound,
      _i3.ddcBuilderSound,
    ],
    _i1.toAllPackages(),
    isOptional: true,
    hideOutput: true,
    appliesBuilders: const [
      r'build_web_compilers:ddc_modules',
      r'build_web_compilers:dart2js_modules',
      r'build_web_compilers:dart_source_cleanup',
    ],
  ),
  _i1.apply(
    r'build_web_compilers:entrypoint',
    [_i3.webEntrypointBuilder],
    _i1.toRoot(),
    hideOutput: true,
    defaultGenerateFor: const _i6.InputSet(
      include: [
        r'web/**',
        r'test/**.dart.browser_test.dart',
        r'example/**',
        r'benchmark/**',
      ],
      exclude: [
        r'test/**.node_test.dart',
        r'test/**.vm_test.dart',
      ],
    ),
    defaultOptions: const _i8.BuilderOptions(<String, dynamic>{
      r'dart2js_args': <dynamic>[r'--minify']
    }),
    defaultDevOptions: const _i8.BuilderOptions(<String, dynamic>{
      r'dart2js_args': <dynamic>[r'--enable-asserts']
    }),
    defaultReleaseOptions:
        const _i8.BuilderOptions(<String, dynamic>{r'compiler': r'dart2js'}),
    appliesBuilders: const [r'build_web_compilers:dart2js_archive_extractor'],
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i2.partCleanup,
  ),
  _i1.applyPostProcess(
    r'angular:placeholder_cleanup',
    _i4.placeholderCleanup,
  ),
  _i1.applyPostProcess(
    r'angular:component_source_cleanup',
    _i4.componentSourceCleanup,
    defaultGenerateFor: const _i6.InputSet(include: [r'lib/**']),
    defaultReleaseOptions:
        const _i8.BuilderOptions(<String, dynamic>{r'enabled': true}),
  ),
  _i1.applyPostProcess(
    r'build_modules:module_cleanup',
    _i7.moduleCleanup,
  ),
  _i1.applyPostProcess(
    r'build_web_compilers:dart2js_archive_extractor',
    _i3.dart2jsArchiveExtractor,
    defaultReleaseOptions:
        const _i8.BuilderOptions(<String, dynamic>{r'filter_outputs': true}),
  ),
  _i1.applyPostProcess(
    r'build_web_compilers:dart_source_cleanup',
    _i3.dartSourceCleanup,
    defaultReleaseOptions:
        const _i8.BuilderOptions(<String, dynamic>{r'enabled': true}),
  ),
];
void main(
  List<String> args, [
  _i9.SendPort sendPort,
]) async {
  var result = await _i10.run(
    args,
    _builders,
  );
  sendPort?.send(result);
  _i11.exitCode = result;
}