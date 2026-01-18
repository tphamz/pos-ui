import 'package:flutter/material.dart';

/// Helper class for showing dialogs over other dialogs
class DialogHelper {
  /// Show a dialog over another dialog
  /// 
  /// Use this when you need to show a second dialog while a first dialog is already open.
  /// The second dialog will appear on top of the first one.
  /// 
  /// Example:
  /// ```dart
  /// // First dialog
  /// showDialog(
  ///   context: context,
  ///   builder: (context) => AlertDialog(title: Text('First Dialog')),
  /// );
  /// 
  /// // Second dialog over the first
  /// DialogHelper.showDialogOverDialog(
  ///   context: context,
  ///   builder: (context) => AlertDialog(title: Text('Second Dialog')),
  /// );
  /// ```
  static Future<T?> showDialogOverDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) {
    // Use rootNavigator to ensure the dialog appears at the root level
    // This allows it to appear over other dialogs
    return showDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  /// Show a nested dialog (dialog over dialog) with proper context handling
  /// 
  /// This method ensures the dialog appears over an existing dialog by using
  /// the root navigator context.
  static Future<T?> showNestedDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    // Get the root navigator to show dialog over existing dialogs
    final navigator = Navigator.of(context, rootNavigator: true);
    
    return showDialog<T>(
      context: context,
      builder: (dialogContext) {
        // The builder receives a new context for the dialog
        return builder(dialogContext);
      },
      barrierDismissible: barrierDismissible,
      useRootNavigator: true, // Important: use root navigator
    );
  }
}

/// Example usage widget showing how to use nested dialogs
class NestedDialogExample extends StatelessWidget {
  const NestedDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Show first dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('First Dialog'),
            content: const Text('This is the first dialog. Click the button to show another dialog on top.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Show second dialog over the first one
                  DialogHelper.showNestedDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Second Dialog'),
                      content: const Text('This dialog appears over the first dialog!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close Second'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close both dialogs
                            Navigator.of(context).pop(); // Close second
                            Navigator.of(context).pop(); // Close first
                          },
                          child: const Text('Close Both'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show Second Dialog'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: const Text('Show Nested Dialogs Example'),
    );
  }
}
