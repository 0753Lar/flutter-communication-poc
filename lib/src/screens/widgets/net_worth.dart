import 'dart:io';

import 'package:dashboard/src/screens/dashboard_modal.dart';
import 'package:dashboard/src/utils/native_channel.dart';
import 'package:dashboard/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetWorth extends StatefulWidget {
  const NetWorth({super.key});
  final reactUrl = "http://172.17.12.53:3000";

  @override
  State<NetWorth> createState() => _NetWorth();
}

class _NetWorth extends State<NetWorth> {
  final textController = TextEditingController();

  Map<String, String> generateParamesWithText() {
    return {"sender": "Flutter", "message": textController.text};
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Platform.isAndroid
        ? "Android"
        : Platform.isIOS
            ? "IOS"
            : "other Platform";

    NativeChannel.onReceiveDialogCallFromNative((data) {
      showCustomDialog(
          context: context, title: "Native sent to Flutter: ", content: data);
    });

    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the message to send',
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  Provider.of<DashboardModal>(context, listen: false)
                      .renderBaseapp(
                          widget.reactUrl, generateParamesWithText());
                },
                child: const Text("send message to react")),
            ElevatedButton(
                onPressed: () {
                  NativeChannel.renderSection(generateParamesWithText());
                },
                child: Text("send message to $platform")),
            ElevatedButton(
                onPressed: () {
                  NativeChannel.getBatteryLevel().then((value) {
                    showCustomDialog(
                        context: context,
                        title: "Native sent to Flutter: ",
                        content: value);
                  });
                },
                child: Text("get bettery level from $platform")),
          ],
        )
      ],
    );
  }
}
