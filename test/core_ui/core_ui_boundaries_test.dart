import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('core_ui only imports packages and its own files', () {
    final RegExp directive = RegExp(r"^(?:import|export)\s+'(package:mijoo/[^']+)'", multiLine: true);
    final List<String> violations = <String>[
      for (final File file in Directory('lib/core_ui').listSync(recursive: true).whereType<File>())
        if (file.path.endsWith('.dart'))
          for (final RegExpMatch match in directive.allMatches(file.readAsStringSync()))
            if (!match.group(1)!.startsWith('package:mijoo/core_ui/')) '${file.path} -> ${match.group(1)}',
    ];
    expect(violations, isEmpty);
  });
}
