import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.color,
    this.onTap,
    this.name,
    this.height,
    this.width,
    this.isLoading = false,
  }) : super(key: key);
  final Color? color;
  final VoidCallback? onTap;
  final String? name;
  final double? height;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onTap,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(name ?? ""),
      ),
    );
  }
}
