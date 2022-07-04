import 'package:flutter/material.dart';

class PasswordInputWithConfirmationDialog extends StatefulWidget {
  static void show({
    required BuildContext context,
    required void Function(String value) onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => PasswordInputWithConfirmationDialog(
        onConfirm: onConfirm,
      ),
    );
  }

  const PasswordInputWithConfirmationDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  final void Function(String value) onConfirm;

  @override
  State<PasswordInputWithConfirmationDialog> createState() =>
      _PasswordInputWithConfirmationDialogState();
}

class _PasswordInputWithConfirmationDialogState
    extends State<PasswordInputWithConfirmationDialog> {
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var passwordFocusNode = FocusNode();
  var confirmFocusNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration.zero)
        .then((value) => passwordFocusNode.requestFocus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Please enter a password",
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "This password will be used to encrypt your file",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(label: Text("Password")),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: passwordController,
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            TextFormField(
              onFieldSubmitted: (value) => onSubmit(),
              decoration: const InputDecoration(
                label: Text("Confirm Password"),
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: confirmController,
              focusNode: confirmFocusNode,
              validator: (value) =>
                  (passwordController.text != confirmController.text)
                      ? "password and confimation must match"
                      : null,
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      actions: [
        TextButton(
          onPressed: onSubmit,
          child: const Text("Confirm"),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  void onSubmit() {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      if (passwordController.text.isNotEmpty) {
        widget.onConfirm(passwordController.text);
      }
      Navigator.of(context).pop();
    }
  }
}
