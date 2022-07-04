import 'package:flutter/material.dart';

void passwordInputPopup({
  required BuildContext context,
  required void Function(String value) onConfirm,
}) async {
  var controller = TextEditingController();
  var focusNode = FocusNode();
  Future.delayed(Duration.zero).then((value) => focusNode.requestFocus());
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Please enter your password"),
        content: TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          controller: controller,
          focusNode: focusNode,
          onSubmitted: (value) {
            if (controller.text.isNotEmpty) {
              onConfirm.call(controller.text);
            }
            Navigator.of(context).pop(true);
          },
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 20,
        ),
      );
    },
  );
}
