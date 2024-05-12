import 'package:flutter/material.dart';
import 'package:story_app/presentation/widgets/show_dialog_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 50,
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'StoryApp',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BriemHand',
                      fontSize: 24),
                ),
                IconButton(
                  onPressed: () {
                    ShowDialogWidget.showErrorDialog(
                      title: 'Coming Soon',
                      message: 'This feature is not available yet',
                      context: context,
                    );
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        ShowDialogWidget.showErrorDialog(
                          title: 'Coming Soon',
                          message: 'This feature is not available yet',
                          context: context,
                        );
                      },
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {
                        ShowDialogWidget.showErrorDialog(
                          title: 'Coming Soon',
                          message: 'This feature is not available yet',
                          context: context,
                        );
                      },
                      icon: const Icon(Icons.message_outlined),
                    ),
                  ],
                ))
              ],
            ),
          );
  }
}