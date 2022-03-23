import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/bloc/post/post_bloc.dart';
import 'package:social/models/response_post.dart';
import 'package:social/models/response_search.dart';
import 'package:social/repositories/post_repository.dart';
import 'package:social/repositories/user_repository.dart';
import 'package:social/ui/screens/search/components/grid_search.dart';
import 'package:social/ui/screens/search/components/list_user.dart';
import 'package:social/ui/screens/search/components/shimmer_search.dart';
import 'package:social/ui/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 10.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: 45,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0)),
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) => TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        postBloc.add(OnIsSearchPostEvent(true));
                        userRepositories.searchUsers(value);
                      } else {
                        postBloc.add(OnIsSearchPostEvent(false));
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Find a friend',
                        hintStyle: GoogleFonts.roboto(fontSize: 17),
                        suffixIcon: const Icon(Icons.search_rounded)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            BlocBuilder<PostBloc, PostState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) => !state.isSearchFriend
                    ? FutureBuilder<List<Post>>(
                        future: postRepositories.getAllPostsForSearch(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const ShimerSearch()
                              : GridPostSearch(posts: snapshot.data!);
                        },
                      )
                    : streamSearchUser())
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationCustom(index: 2),
    );
  }

  Widget streamSearchUser() {
    return StreamBuilder<List<UserFind>>(
      stream: userRepositories.searchProducts,
      builder: (context, snapshot) {
        if (snapshot.data == null) return Container();

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.isEmpty) {
          return ListTile(
            title: TextCustom(text: 'No results for ${_searchController.text}'),
          );
        }

        return ListUsers(listUser: snapshot.data!);
      },
    );
  }
}
