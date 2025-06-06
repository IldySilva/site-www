// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';

import 'src/commands/analyze_dart.dart';
import 'src/commands/build.dart';
import 'src/commands/check_all.dart';
import 'src/commands/check_link_references.dart';
import 'src/commands/check_links.dart';
import 'src/commands/check_markdown.dart';
import 'src/commands/check_site_variable.dart';
import 'src/commands/format_dart.dart';
import 'src/commands/freshness.dart';
import 'src/commands/generate_diagnostics.dart';
import 'src/commands/generate_effective_dart_toc.dart';
import 'src/commands/generate_lints.dart';
import 'src/commands/refresh_excerpts.dart';
import 'src/commands/serve.dart';
import 'src/commands/test_dart.dart';
import 'src/commands/verify_firebase_json.dart';

/// The root command runner of the `dart_site` command.
/// To learn about it and its subcommands,
/// run `dart run dart_site --help`.
final class DartSiteCommandRunner extends CommandRunner<int> {
  DartSiteCommandRunner()
    : super(
        'dart_site',
        'Infrastructure tooling for the Dart documentation website.',
      ) {
    addCommand(CheckLinksCommand());
    addCommand(CheckLinkReferencesCommand());
    addCommand(CheckMarkdownCommand());
    addCommand(CheckSiteVariableCommand());
    addCommand(VerifyFirebaseJsonCommand());
    addCommand(RefreshExcerptsCommand());
    addCommand(FormatDartCommand());
    addCommand(FreshnessCommand());
    addCommand(GenerateDiagnosticDocs());
    addCommand(GenerateLintDocs());
    addCommand(GenerateEffectiveDartToc());
    addCommand(AnalyzeDartCommand());
    addCommand(TestDartCommand());
    addCommand(CheckAllCommand());
    addCommand(BuildSiteCommand());
    addCommand(ServeSiteCommand());
  }
}
