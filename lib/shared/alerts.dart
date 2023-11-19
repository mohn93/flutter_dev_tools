import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppDevAlerts {
  static void showInfoDialog(
    BuildContext context, {
    String? message,
    Widget? widget,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: (widget != null) ? widget : Text(message!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void showBottomSheet(
    BuildContext context, {
    String? title,
    String? message,
    Widget? widget,
  }) {
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: true,showDragHandle: true,isDismissible: true,
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                top: 24,
                right: 24,
                left: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32),
            child: (widget != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                      if (title != null)
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon:  Icon(Icons.close,color: Theme.of(context).colorScheme.onSurface,),
                        ),

                      ],),
                      const Gap(16),
                      widget,
                    ],
                  )
                : Text(message!),
          ),
        );
      },
    );
  }
}
