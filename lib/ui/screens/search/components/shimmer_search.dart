import 'package:flutter/material.dart';
import 'package:social/ui/widgets/widgets.dart';

class ShimerSearch extends StatelessWidget {
  const ShimerSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ShimmerCustom(),
        SizedBox(height: 10.0),
        ShimmerCustom(),
        SizedBox(height: 10.0),
        ShimmerCustom(),
      ],
    );
  }
}
