import 'package:dashboard/src/sections/accounts_section.dart';
import 'package:dashboard/src/sections/congrate_section.dart';
import 'package:dashboard/src/sections/link_more_section.dart';
import 'package:dashboard/src/sections/quick_link_section.dart';
import 'package:flutter/material.dart';

class TabviewSummary extends StatelessWidget {
  const TabviewSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(flex: 0, child: QuickLinkSection()),
        Expanded(flex: 0, child: AccountsSection()),
        Expanded(flex: 0, child: CongrateSection()),
        Expanded(flex: 0, child: LinkMoreSection()),
      ],
    ));
  }
}
