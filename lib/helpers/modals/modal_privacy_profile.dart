part of "modals.dart";

modalPrivacyProfile(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final userBloc = BlocProvider.of<UserBloc>(context);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
    backgroundColor: Colors.white,
    barrierColor: Colors.black26,
    builder: (context) => Container(
      height: size.height * .41,
      width: size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 38,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            const SizedBox(height: 15.0),
            Center(
                child: BlocBuilder<UserBloc, UserState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (_, state) => TextCustom(
                        text: (state.user != null && state.user!.isPrivate == 0)
                            ? 'Change account to Private'
                            : 'Change account to Public',
                        fontWeight: FontWeight.w500))),
            const SizedBox(height: 5.0),
            const Divider(),
            const SizedBox(height: 10.0),
            Row(
              children: const [
                Icon(Icons.photo_outlined, size: 30, color: Colors.black),
                SizedBox(width: 10.0),
                TextCustom(
                    text: 'Everyone can see your photos and videos',
                    fontSize: 15,
                    color: Colors.grey)
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: const [
                Icon(Icons.chat_bubble_outline_rounded,
                    size: 30, color: Colors.black),
                SizedBox(width: 10.0),
                TextCustom(
                  text: 'This will not change who can tag you \n@mention',
                  fontSize: 15,
                  color: Colors.grey,
                  maxLines: 2,
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: const [
                Icon(Icons.person_add_alt, size: 30, color: Colors.black),
                SizedBox(width: 10.0),
                TextCustom(
                  text:
                      'All pending requests must \n be approved unless you delete them',
                  fontSize: 15,
                  color: Colors.grey,
                  maxLines: 2,
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(height: 10.0),
            BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) => previous != current,
              builder: (_, state) => BtnCustom(
                text: (state.user != null && state.user!.isPrivate == 0)
                    ? 'Switch to Private'
                    : 'Change to Public',
                width: size.width,
                fontSize: 17,
                backgroundColor: ColorsSM.primary,
                onPressed: () {
                  Navigator.pop(context);
                  userBloc.add(OnChangeAccountToPrivacy());
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}
