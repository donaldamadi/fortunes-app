import 'package:flutter/material.dart';

/// Write documentation for this class
///
/// A dialog that displays a error alert.
///
/// This dialog is used to show a success message to the user. It can be used to indicate
/// that an operation was successful or to provide feedback on a completed task.
///
/// N.B: the secondLabel can only be provided if secondButton is true.
///
/// Example usage:
///
/// ```dart
/// showInfoAlertDialog(
///   asset: AppAssets.success,
///   label: 'Success',
///   secondButton: true,
///   secondLabel: 'Second Button'
///   onDismiss: () {
///     // Handle dialog dismissal
///   },
/// );
/// ```
void showInfoAlertDialog(
  BuildContext context, {
  String? message,
  bool secondButton = false,
  String? label,
  String? secondLabel,
  required Function() action,
  Function()? secondAction,
  AlignmentGeometry? alignment,
}) {
  if (secondButton && secondLabel == null) {
    secondLabel = ""; // Default value if not provided
  }

  if (!secondButton && secondLabel != null) {
    throw ArgumentError("secondLabel can only be provided if secondButton is true.");
  }

  _showDialog(context, message, secondButton, secondLabel, action, secondAction, label, alignment);
}

void _showDialog(
  BuildContext context,
  String? message,
  bool secondButton,
  String? secondLabel,
  Function() action,
  Function()? secondAction,
  String? label,
  AlignmentGeometry? alignment,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Builder(
          builder: (context) {
            return AlertDialog(
              alignment: alignment,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      message ?? "An error occurred, please try again later.",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onPressed: action,
                      child: const Text("DISMISS"),
                    ),
                  ),
                  if (secondButton)
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: secondAction,
                        child: Text(
                          secondLabel ?? "",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
