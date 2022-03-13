part of 'widgets.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  const TextFieldCustom(
      {Key? key,
      required this.controller,
      this.hintText,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      cursorColor: ColorsSM.secundary,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsSM.primary)),
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
