import 'package:custom_widgets/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class LinkMoreSection extends StatelessWidget {
  const LinkMoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: CardWidget(
        backgroundColor: Colors.black87,
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        "YOU MAY LIKE THIS",
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Live Green with Live Fresh",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Get additional 5% Green Cashback with Singapore's first ever eco-friendly card.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Learn more >",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400]),
                      ),
                    ])),
                const FlutterLogo(
                  size: 120,
                  style: FlutterLogoStyle.markOnly,
                ),
              ],
            )),
      ),
    );
  }
}
