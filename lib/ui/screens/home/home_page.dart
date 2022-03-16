import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/helpers/helpers.dart';
import 'package:social/helpers/modals/modals.dart';
import 'package:social/models/response_post.dart';
import 'package:social/repositories/post_repository.dart';
import 'package:social/ui/screens/home/components/list_histories.dart';
import 'package:social/ui/screens/home/components/list_view_post.dart';
import 'package:social/ui/screens/home/components/list_without_post.dart';
import 'package:social/ui/themes/colors.dart';
import 'package:social/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
              text: 'Social Media',
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: ColorsSM.secundary,
              isTitle: true,
            ),
            elevation: 0,
            actions: [
              IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        routeSlide(page: const AddPostPage()), (_) => false);
                  },
                  icon: SvgPicture.asset('assets/svg/add_rounded.svg',
                      height: 32)),
              IconButton(
                  splashRadius: 20,
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      routeSlide(page: const NotificationsPage()),
                      (_) => false),
                  icon: SvgPicture.asset('assets/svg/notification-icon.svg',
                      height: 26)),
              IconButton(
                  splashRadius: 20,
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const ListMessagesPage())),
                  icon:
                      SvgPicture.asset('assets/svg/chat-icon.svg', height: 24)),
            ],
          ),
          body: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const ListHistories(),
                const SizedBox(height: 5.0),
                FutureBuilder<List<Post>>(
                  future: postRepositories.getAllPostHome(),
                  builder: (_, snapshot) {
                    if (snapshot.data != null && snapshot.data!.isEmpty) {
                      return ListWithoutPosts();
                    }

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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, i) =>
                                ListViewPosts(posts: snapshot.data![i]),
                          );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavigationCustom(index: 1)),
    );
  }
}
