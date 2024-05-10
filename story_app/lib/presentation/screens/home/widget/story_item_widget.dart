import 'package:flutter/material.dart';

import '../../../../utils/constant/color_constant.dart';

class StoryItemWidget extends StatelessWidget {
  final String? name;
  final String? description;
  final String? date;
  final String? photoUrl;
  final Function()? onTap;

  const StoryItemWidget({
    super.key,
    this.name,
    this.description,
    this.date,
    this.photoUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorConstant.onPrimaryColor,
                            radius: 18,
                            child: Text(name![0].toUpperCase()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Column(
                              children: [
                                Text(name!),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.gif',
                    image: photoUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.mode_comment_outlined)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.send)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.archive_outlined)),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("$name "),
                          Expanded(
                            child: Text(description!),
                          )
                        ],
                      ),
                      Row(
                        children: [Text("$date")],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
