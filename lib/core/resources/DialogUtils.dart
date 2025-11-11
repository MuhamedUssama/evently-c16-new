import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Center(child: CircularProgressIndicator())],
        ),
      ),
    );
  }

  static showMessageDialog({
    required BuildContext context,
    required String message,
    required String positiveActionTitle,
    required void Function() positiveActionPress,
    String? negativeActionTitle,
    void Function()? negativeActionPress,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: positiveActionPress,
            child: Text(positiveActionTitle),
          ),
          if (negativeActionTitle != null) ...[
            TextButton(
              onPressed: negativeActionPress,
              child: Text(negativeActionTitle),
            ),
          ],
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsManager.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
