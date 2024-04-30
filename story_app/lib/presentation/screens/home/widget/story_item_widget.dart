import 'package:flutter/material.dart';

import '../../../../utils/constant/color_constant.dart';

class StoryItemWidget extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final String photoUrl;
  final Function()? onTap;

  const StoryItemWidget({
    super.key,
    required this.name,
    required this.description,
    required this.date,
    required this.photoUrl,
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
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorConstant.webBackgroundColor,
                            radius: 18,
                            child: Text(name[0].toUpperCase()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Column(
                              children: [
                                Text(name),
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
                  child: Image.network(
                    photoUrl,
                    fit: BoxFit.fill,
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
                              child: Text(description),
                            )
                          ],
                        ),
                        Row(
                          children: [Text("$date minutes ago")],
                        )
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
