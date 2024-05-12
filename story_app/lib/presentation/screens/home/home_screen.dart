import 'package:flutter/material.dart';
import 'package:story_app/presentation/screens/home/widget/list_story_highlight_widget.dart';
import 'package:story_app/presentation/screens/home/widget/list_story_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                const SizedBox(width: 12,),
                const Text(
                  'StoryApp',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'BriemHand',fontSize: 24),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_drop_down),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message_outlined),
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 124,
            width: MediaQuery.of(context)
                .size
                .width, 
            child: const ListStoryHighlightWidget(),
          ),
          const ListStoryWidget(),
        ],
      ),
    );

  }
}
