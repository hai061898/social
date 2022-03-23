part of 'modals.dart';

modalOptionsReel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * .36,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            const SizedBox(height: 10.0),
            ItemModal(
              icon: Icons.report_gmailerrorred_outlined,
              text: 'Report',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ItemModal(
              icon: Icons.no_accounts_rounded,
              text: 'I m not interested',
              onPressed: () {},
            ),
            ItemModal(
              icon: Icons.copy_all_rounded,
              text: 'Copy Link',
              onPressed: () {},
            ),
            ItemModal(
              icon: Icons.share_outlined,
              text: 'Share',
              onPressed: () {},
            ),
            ItemModal(
              icon: Icons.save_outlined,
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}

class ItemModal extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onPressed;

  const ItemModal(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(primary: ColorsSM.secundary),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(icon, color: Colors.black87),
                const SizedBox(width: 10.0),
                TextCustom(text: text, fontSize: 17)
              ],
            )),
      ),
    );
  }
}
