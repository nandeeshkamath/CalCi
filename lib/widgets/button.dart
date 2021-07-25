import 'package:flutter/material.dart';
import 'package:simple_calculator/animation/fade_animation.dart';
import 'package:simple_calculator/constants/keyset.dart' as key_set;

class KeyButton extends StatelessWidget {
  final key_set.KeySet symbol;
  final Function onTap;
  const KeyButton({Key? key, required this.symbol, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _text = symbol.value;
    final _textColor = symbol.color;
    final _backgroundColor = symbol.bgColor;
    final _fontSize = size.height / 27;

    return FadeAnimation(
        1.3,
        Container(
          margin: const EdgeInsets.all(10),
          height: size.height / 11,
          width: size.width / 5,
          child: ElevatedButton(
            onPressed: () {
              onTap(_text);
            },
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(_backgroundColor)),
            child: Text(
              _text,
              style: TextStyle(color: _textColor, fontSize: _fontSize),
            ),
          ),
        ));
  }
}
