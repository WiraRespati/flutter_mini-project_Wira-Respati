import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/screens/home/widget/story_item_widget.dart';
import 'package:story_app/utils/constant/date_constant.dart';

import '../../../../utils/constant/name_routes.dart';
import '../../../bloc/story/list/list_story_bloc.dart';
import '../../../bloc/story/list/list_story_event.dart';
import '../../../bloc/story/list/list_story_state.dart';

class ListStoryWidget extends StatefulWidget {
  const ListStoryWidget({super.key});

  @override
  State<ListStoryWidget> createState() => _ListStoryWidgetState();
}

class _ListStoryWidgetState extends State<ListStoryWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListStoryBloc>(context).add(const ListStoryButtonPressed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListStoryBloc, ListStoryState>(
      builder: (context, state) {
        if (state is ListStoryLoading) {
          return const SizedBox(
            height: 500,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ListStorySuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ListStoryBloc>(context)
                  .add(const ListStoryButtonPressed());
            },
            child: Column(
              children: state.stories.listStory!.map((story) {
                final date =
                    DateConstant.getTimeDifference(story.createdAt.toString());
                return StoryItemWidget(
                  name: story.name,
                  description: story.description,
                  date: date,
                  photoUrl: story.photoUrl,
                  onTap: () {
                    Navigator.pushNamed(
                        context, NameRoutes.detailStoryPageRoute,
                        arguments: story.id);
                  },
                );
              }).toList(),
            ),
          );
        } else if (state is ListStoryFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      'Failed to load stories: Check your internet connection'),
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
