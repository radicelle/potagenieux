import 'package:flutter/material.dart';

class MenuInfo extends StatelessWidget {
  const MenuInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Potagénieux",
          style: TextStyle(color: Colors.white),
        ),
        Text("2 impasse des Roquerets", style: TextStyle(color: Colors.white)),
        Text("14500 Vire", style: TextStyle(color: Colors.white)),
        Text("Tel : 0679122243", style: TextStyle(color: Colors.white))
      ],
    );
  }
}
