part of 'modals.dart';

void errorMessageSnack(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: TextCustom(text: error, color: Colors.white),
    backgroundColor: Colors.red,
  ));
}
