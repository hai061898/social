import 'package:flutter/material.dart';
import 'package:social/helpers/helpers.dart';
import 'package:social/models/response_search.dart';
import 'package:social/services/url_api.dart';
import 'package:social/ui/screens/profile/profile_another_user_page.dart';
import 'package:social/ui/widgets/widgets.dart';

class ListUsers extends StatelessWidget {
  final List<UserFind> listUser;

  const ListUsers({
    Key? key,
    required this.listUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listUser.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                routeSlide(
                    page: ProfileAnotherUserPage(idUser: listUser[i].uid)));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 5.0),
              height: 70,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(UA.baseUrl + listUser[i].avatar),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustom(text: listUser[i].username),
                      TextCustom(
                          text: listUser[i].fullname, color: Colors.grey),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
