import 'package:flutter/material.dart';
import 'package:social/helpers/modals/modals.dart';
import 'package:social/models/response_post.dart';
import 'package:social/services/url_api.dart';

class GridPostSearch extends StatelessWidget {
  final List<Post> posts;

  const GridPostSearch({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            mainAxisExtent: 170),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, i) {
          final List<String> listImages = posts[i].images.split(',');

          return GestureDetector(
            onTap: () {},
            onLongPress: () => modalShowPost(context, post: posts[i]),
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(UA.baseUrl + listImages.first)))),
          );
        });
  }
}
