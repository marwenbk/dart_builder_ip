import 'package:build/build.dart';
import 'package:dart_builder_ip/dart_builder_ip.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  group('Builder IP', () {
    final builder = builderIPBuilder(BuilderOptions.empty);

    setUp(() {});

    test('returns builder', () {
      expect(builder, isA<LibraryBuilder>());
    });
  });
}
