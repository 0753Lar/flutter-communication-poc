import 'package:flutter/material.dart';

class DashboardModal extends ChangeNotifier {
  final Function showWebview;
  final Function hideWebview;
  final Function(String url, Map<String, dynamic>? params) renderBaseapp;
  final Function isWebviewVisible;

  DashboardModal(this.showWebview, this.hideWebview, this.renderBaseapp,
      this.isWebviewVisible);
}
