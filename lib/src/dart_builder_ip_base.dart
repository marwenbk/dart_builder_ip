import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'dart:io';

class BuilderIP extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    var ip = "localhost";
    for (var interface in await NetworkInterface.list(includeLinkLocal: true)) {
      for (var addr in interface.addresses) {
        log.info("Checking ${addr.address} (${addr.type.name})");
        if (addr.type.name == 'IPv4') {
          ip = addr.address;
          break;
        }
      }
    }
    if (ip == "localhost") {
      log.warning(
          "Can't find IPv4 local up. Using localhost, so debugging on physical devices will not work.");
    }
    return '''
// Source library: ${library.element.source.uri}
part of "${library.element.source.shortName}";

const builderIp = '$ip';
''';
  }
}

Builder builderIPBuilder(BuilderOptions options) => LibraryBuilder(
      BuilderIP(),
      generatedExtension: '.builder-ip.dart',
    );
