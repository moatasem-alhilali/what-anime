import 'package:flutter/services.dart';

int currentTab = 0;
void copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  print("done");
}

bool isArabic = false;
bool isSplash = true;
String username = "";
