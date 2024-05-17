
import 'dart:io';

import 'package:flutter/cupertino.dart';

class AlertEngine {
  static showNetworkError(BuildContext context, Function() onRetry) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Network Error"),
        content: const Text("We are facing some server issue please retry"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Retry Now"),
            onPressed: () {
              onRetry();
            },
          ),
        ],
      ),
    );
  }

  static showCloseApp(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Network Error"),
        content: const Text(
            "We are facing some server issue please retry after some time."),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("close app"),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
