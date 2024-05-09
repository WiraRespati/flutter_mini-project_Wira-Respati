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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const Text(
                  'Story App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
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
                ),
              )
            ],
            floating: true,
            pinned: true,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListStoryHighlightWidget(),
            ),
          ),
          const SliverFillRemaining(
            child: ListStoryWidget(),
          ),
        ],
      ),
    );
  }
}
