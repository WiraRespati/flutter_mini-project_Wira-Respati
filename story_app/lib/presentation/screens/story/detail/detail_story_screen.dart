import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/screens/home/widget/story_item_widget.dart';

import '../../../../utils/constant/date_constant.dart';
import '../../../bloc/story/detail/detail_story_bloc.dart';
import '../../../bloc/story/detail/detail_story_event.dart';
import '../../../bloc/story/detail/detail_story_state.dart';

class DetailStoryScreen extends StatefulWidget {
  const DetailStoryScreen({super.key});

  @override
  State<DetailStoryScreen> createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  late String storyId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    storyId = ModalRoute.of(context)?.settings.arguments as String;
    BlocProvider.of<DetailStoryBloc>(context)
        .add(DetailStoryButtonPressed(storyId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Story"),
          centerTitle: true,
        ),
        body: BlocBuilder<DetailStoryBloc, DetailStoryState>(
          builder: (context, state) {
            if (state is DetailStoryLoading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is DetailStorySuccess) {
              final date = DateConstant.minute(state.stories.createdAt.toString());
              return Column(
                children: [
                  StoryItemWidget(
                      name: state.stories.name,
                      description: state.stories.description,
                      date: date,
                      photoUrl: state.stories.photoUrl)
                ],
              );
            } else if (state is DetailStoryFailure) {
              return Center(child: Text('Failed to load story: ${state.error}'),);
            } else {
              return const Text('Unknown error');
            }
          },
        ));
  }
}
