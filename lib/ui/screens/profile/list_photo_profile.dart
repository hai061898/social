import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/helpers/helpers.dart';
import 'package:social/helpers/modals/modals.dart';
import 'package:social/models/response_post_by_user.dart';
import 'package:social/repositories/post_repository.dart';
import 'package:social/services/url_api.dart';
import 'package:social/ui/screens/comments/comment_post_page.dart';
import 'package:social/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListPhotosProfilePage extends StatefulWidget {
  const ListPhotosProfilePage({Key? key}) : super(key: key);

  @override
  State<ListPhotosProfilePage> createState() => _ListPhotosProfilePageState();
}

class _ListPhotosProfilePageState extends State<ListPhotosProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingSavePost || state is LoadingPost) {
          modalLoadingShort(context);
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(
              text: 'Publicaciones', fontWeight: FontWeight.w500),
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black)),
        ),
        body: FutureBuilder<List<PostUser>>(
          future: postRepositories.listPostByUser(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Column(
                    children: const [
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      final List<String> listImages =
                          snapshot.data![i].images.split(',');

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          height: 350,
                          width: size.width,
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
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    autoPlay: false,
                                  ),
                                  itemBuilder: (context, i, realIndex) =>
                                      Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                UA.baseUrl + listImages[i]))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              UA.baseUrl +
                                                  snapshot.data![i].avatar),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextCustom(
                                                text:
                                                    snapshot.data![i].username,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                            TextCustom(
                                                text: timeago.format(
                                                    snapshot.data![i].createdAt,
                                                    locale: 'es'),
                                                fontSize: 14,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        splashRadius: 20,
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.more_vert_rounded,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 25,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    height: 45,
                                    width: size.width * .95,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5.0, sigmaY: 5.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          color: Colors.white.withOpacity(0.2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () => postBloc
                                                        .add(OnLikeOrUnLikePost(
                                                            snapshot.data![i]
                                                                .postUid,
                                                            snapshot.data![i]
                                                                .personUid)),
                                                    child: Row(
                                                      children: [
                                                        snapshot.data![i]
                                                                    .isLike ==
                                                                1
                                                            ? const Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color:
                                                                    Colors.red)
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_outline_rounded,
                                                                color: Colors
                                                                    .white),
                                                        const SizedBox(
                                                            width: 8.0),
                                                        TextCustom(
                                                            text: snapshot
                                                                .data![i]
                                                                .countLikes
                                                                .toString(),
                                                            fontSize: 16,
                                                            color: Colors.white)
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20.0),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          routeFade(
                                                              page: CommentsPostPage(
                                                                  uidPost: snapshot
                                                                      .data![i]
                                                                      .postUid)));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/svg/message-icon.svg',
                                                            color:
                                                                Colors.white),
                                                        const SizedBox(
                                                            width: 5.0),
                                                        TextCustom(
                                                            text: snapshot
                                                                .data![i]
                                                                .countComment
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
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons
                                                              .bookmark_outline_sharp,
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
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
