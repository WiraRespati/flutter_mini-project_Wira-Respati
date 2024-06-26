import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/screens/home/widget/story_item_widget.dart';
import 'package:story_app/presentation/screens/story/detail/detail_story_maps_widget.dart';
import 'package:story_app/presentation/screens/story/detail/header_detail_widget.dart';
import 'package:story_app/utils/constant/color_constant.dart';

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
          title: const HeaderDetailWidget(),
          centerTitle: true,
        ),
        body: BlocBuilder<DetailStoryBloc, DetailStoryState>(
          builder: (context, state) {
            if (state is DetailStoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailStorySuccess) {
              final date = DateConstant.getTimeDifference(
                  state.stories.story!.createdAt.toString());
              final detail = state.stories.story;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    StoryItemWidget(
                        name: detail?.name,
                        description: detail?.description,
                        date: date,
                        photoUrl: detail?.photoUrl),
                    (detail?.lat != null && detail?.lon != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              margin: const EdgeInsets.all(32),
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                              color: ColorConstant.onPrimaryColor,
                              child: DetailStoryMapsWidget(
                                  lat: detail!.lat!, lon: detail.lon!),
                            ),
                          )
                        : const Center(child: Text('Lokasi tidak tersedia')),
                  ],
                ),
              );
            } else if (state is DetailStoryFailure) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load story: ${state.error}'),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        BlocProvider.of<DetailStoryBloc>(context)
                            .add(DetailStoryButtonPressed(storyId));
                      },
                    )
                  ],
                ),
              ));
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
                          BlocProvider.of<DetailStoryBloc>(context)
                              .add(DetailStoryButtonPressed(storyId));
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
