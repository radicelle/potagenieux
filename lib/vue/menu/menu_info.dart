import 'package:flutter/material.dart';

class MenuInfo extends StatelessWidget {
  const MenuInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white60;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Potagénieux",
            style: TextStyle(
              color: textColor,
            ),
          ),
          Text("2 impasse des Roquerets", style: TextStyle(color: textColor)),
          Text("14500 Vire", style: TextStyle(color: textColor)),
          Text("Tel : 0679122243", style: TextStyle(color: textColor))
        ],
      ),
    );
  }
}
