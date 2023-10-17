import 'dart:io';

import 'package:flutter/material.dart';

class NetWorkImageTestable {
  const NetWorkImageTestable({
    required this.url,
  });

  final String url;

  ImageProvider build(BuildContext context) {
    //To solve HTTP request in test wip issue
    final isTest = Platform.environment.containsKey('FLUTTER_TEST');
    if (isTest) {
      return const AssetImage('assets/harry.jpg');
    } else {
      return NetworkImage(url);
    }
  }
}
