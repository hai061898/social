import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/helpers/helpers.dart';
import 'package:social/services/url_api.dart';
import 'package:social/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social/models/response_post.dart';

class ListViewPosts extends StatelessWidget {
  final Post posts;

  const ListViewPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    final List<String> listImages = posts.images.split(',');
    final time = timeago.format(posts.createdAt, locale: 'es');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        height: 350,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.grey[100]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CarouselSlider.builder(
                itemCount: listImages.length,
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  height: 350,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: false,
                ),
                itemBuilder: (context, i, realIndex) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(UA.baseUrl + listImages[i]))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(UA.baseUrl + posts.avatar),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                      text: posts.username,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  TextCustom(
                                      text: time,
                                      fontSize: 15,
                                      color: Colors.white),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert_rounded,
                                  color: Colors.white, size: 25))
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        height: 45,
                        width: size.width * .9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              color: Colors.white.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => postBloc.add(
                                                OnLikeOrUnLikePost(
                                                    posts.postUid,
                                                    posts.personUid)),
                                            child: posts.isLike == 1
                                                ? const Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.red)
                                                : const Icon(
                                                    Icons
                                                        .favorite_outline_rounded,
                                                    color: Colors.white),
                                          ),
                                          const SizedBox(width: 8.0),
                                          InkWell(
                                              onTap: () {},
                                              child: TextCustom(
                                                  text: posts.countLikes
                                                      .toString(),
                                                  fontSize: 16,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      const SizedBox(width: 20.0),
                                      TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            routeFade(
                                                page: CommentsPostPage(
                                                    uidPost: posts.postUid))),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/message-icon.svg',
                                                color: Colors.white),
                                            const SizedBox(width: 5.0),
                                            TextCustom(
                                                text: posts.countComment
                                                    .toString(),
                                                fontSize: 16,
                                                color: Colors.white)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: SvgPicture.asset(
                                              'assets/svg/send-icon.svg',
                                              height: 24,
                                              color: Colors.white)),
                                      IconButton(
                                          onPressed: () => postBloc.add(
                                              OnSavePostByUser(posts.postUid)),
                                          icon: const Icon(
                                              Icons.bookmark_border_rounded,
                                              size: 27,
                                              color: Colors.white))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
