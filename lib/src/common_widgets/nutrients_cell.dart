import 'package:flutter/material.dart';
import '../constants/colors.dart';

class NutrientsCell extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onChanged;
  final String icon;
  final TextEditingController textController;

  const NutrientsCell({
    Key? key,
    required this.title,
    this.onChanged,
    required this.icon,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(
        children: [
          Image(
            image: AssetImage(icon),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: TColor.primaryG,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
            },
            child: Text(
              title,
              style: TextStyle(
                color: TColor.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textController,
                  textAlign: TextAlign.center,
                  onChanged: onChanged,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: TextStyle(color: TColor.gray),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: TColor.primaryG,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  "g",
                  style: TextStyle(
                    color: TColor.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
