import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/bloc/user/user_bloc.dart';
import 'package:social/helpers/helpers.dart';
import 'package:social/models/response_stories.dart';
import 'package:social/repositories/story_repository.dart';
import 'package:social/services/url_api.dart';
import 'package:social/ui/widgets/widgets.dart';

class ListHistories extends StatelessWidget {
  const ListHistories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 90,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) => state.user != null
                  ? InkWell(
                      onTap: () => Navigator.push(
                          context, routeSlide(page: const AddStoryPage())),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [Colors.pink, Colors.amber])),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(UA.baseUrl +
                                          state.user!.image.toString()))),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextCustom(text: state.user!.username, fontSize: 15)
                        ],
                      ),
                    )
                  : const CircleAvatar()),
          const SizedBox(width: 10.0),
          SizedBox(
            height: 90,
            width: size.width,
            child: FutureBuilder<List<StoryHome>>(
              future: storyRepositories.getAllStoriesHome(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const ShimmerCustom()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                                context,
                                routeFade(
                                    page: ViewStoryPage(
                                        storyHome: snapshot.data![i]))),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            colors: [
                                              Colors.pink,
                                              Colors.amber
                                            ])),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(UA.baseUrl +
                                                  snapshot.data![i].avatar))),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  TextCustom(
                                      text: snapshot.data![i].username,
                                      fontSize: 15)
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
