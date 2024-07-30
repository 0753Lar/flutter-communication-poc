import 'package:custom_widgets/widgets/quick_link_widget.dart';
import 'package:flutter/material.dart';

final List<(IconData, String)> quickLinkList = [
  (Icons.loop_outlined, "Transfer"),
  (Icons.payment, "PayNow"),
  (Icons.currency_exchange, "Exchange Currency"),
  (Icons.document_scanner_outlined, "eDocs"),
];

class QuickLinkSection extends StatelessWidget {
  const QuickLinkSection({super.key});

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
                    )
                  ],
                )))
            .toList(),
      ),
    );
  }
}
