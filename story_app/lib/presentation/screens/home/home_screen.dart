import 'package:flutter/material.dart';
import 'package:story_app/presentation/screens/home/widget/home_appbar_widget.dart';
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
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          title: HomeAppBarWidget(),
          floating: true,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 124,
            width: MediaQuery.of(context).size.width,
            child: const ListStoryHighlightWidget(),
          ),
        ),
        const SliverToBoxAdapter(
          child: ListStoryWidget(),
        ),
      ],
    );
  }
}
