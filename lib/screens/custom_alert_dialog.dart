import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? imagePath;
  final List<Widget> actions;

  const CustomAlertDialog({
    super.key,
    this.title,
    required this.message,
    this.imagePath,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Adjust as needed
      ),
      contentPadding: const EdgeInsets.all(20.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Image.asset(
                  imagePath!,
                  width: 80, // Adjust image size as needed
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            ),
            if (actions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: actions,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showCustomAlertDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? imagePath,
  List<Widget>? actions,
}) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // You can change this if you want to allow closing by tapping outside
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        message: message ?? '',
        imagePath: imagePath,
        actions: actions ?? [],
      );
    },
  );
}
