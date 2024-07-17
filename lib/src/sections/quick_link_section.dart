import 'package:custom_widgets/widgets/quick_link_widget.dart';
import 'package:dashboard/src/widgets/custom_webview_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<(IconData, String)> quickLinkList = [
  (Icons.loop_outlined, "Local Transfer"),
  (Icons.currency_exchange, "Exchange Currency"),
  (Icons.payment, "PayNow"),
  (Icons.document_scanner_outlined, "eDocs"),
];

class QuickLinkSection extends StatelessWidget {
  const QuickLinkSection({super.key});
  final reactUrl = "http://localhost:3000";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: quickLinkList
            .map((tuple) => Expanded(
                    child: Column(
                  children: [
                    QuickLinkWidget(
                      icon: tuple.$1,
                      text: tuple.$2,
                      onTap: () => Provider.of<CustomWebviewModal>(context,
                              listen: false)
                          .renderBaseapp(reactUrl,
                              {"text": tuple.$2, "icon": tuple.$1.toString()}),
                    )
                  ],
                )))
            .toList(),
      ),
    );
  }
}
