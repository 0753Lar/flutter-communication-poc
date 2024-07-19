import 'package:custom_widgets/widgets/card_widget.dart';
import 'package:dashboard/src/utils/native_channel.dart';
import 'package:dashboard/src/widgets/showCustomDialog.dart';
import 'package:flutter/material.dart';

class CongrateSection extends StatelessWidget {
  const CongrateSection({super.key});

  @override
  Widget build(BuildContext context) {
    NativeChannel.onReceiveDialogCallFromNative((data) {
      showCustomDialog(
          context: context, title: "Native sent to Flutter: ", content: data);
    });
    return CardWidget(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text(
                            "Congrats on getting your new card, Lisa!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "14 Jun 2021",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Hi Lisa, we've got some warm up tips just for you.",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ])),
                    const FlutterLogo(
                      size: 70,
                      style: FlutterLogoStyle.markOnly,
                    ),
                  ],
                )),
            Divider(color: Colors.grey[100]),
            Container(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  child: const Text(
                    "See all >",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    NativeChannel.renderSection({
                      "section": "congratSection",
                      "buttonText": "See All >"
                    });
                  },
                ))
          ],
        ));
  }
}
