import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_bloc.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_event.dart';
import 'package:story_app/presentation/bloc/story/list/list_story_state.dart';
import 'package:story_app/presentation/screens/home/widget/story_highlight_widget.dart';
import 'package:story_app/utils/constant/name_routes.dart';

class ListStoryHighlightWidget extends StatefulWidget {
  const ListStoryHighlightWidget({super.key});

  @override
  State<ListStoryHighlightWidget> createState() =>
      _ListStoryHighlightWidgetState();
}

class _ListStoryHighlightWidgetState extends State<ListStoryHighlightWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<ListStoryBloc>(context).add(const ListStoryButtonPressed());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.minScrollExtent &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      BlocProvider.of<ListStoryBloc>(context)
          .add(const ListStoryButtonPressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListStoryBloc, ListStoryState>(
      builder: (context, state) {
        if (state is ListStoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ListStorySuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              // Trigger refresh when user pulls the screen upwards
              BlocProvider.of<ListStoryBloc>(context)
                  .add(const ListStoryButtonPressed());
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: state.stories.listStory?.length,
              itemBuilder: (context, index) {
                final story = state.stories.listStory![index];
                return StoryHighlightWidget(
                  name: story.name!,
                  onTap: () {
                    Navigator.pushNamed(
                        context, NameRoutes.detailStoryPageRoute,
                        arguments: story.id);
                  },
                );
              },
            ),
          );
        } else if (state is ListStoryFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to load stories: ${state.error}'),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      BlocProvider.of<ListStoryBloc>(context)
                          .add(const ListStoryButtonPressed());
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unknown Error'),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      BlocProvider.of<ListStoryBloc>(context)
                          .add(const ListStoryButtonPressed());
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
