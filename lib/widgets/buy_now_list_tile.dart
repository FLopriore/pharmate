import 'package:flutter/material.dart';

class BuyNowListTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final VoidCallback? onPressed;
  final bool isActivated;

  const BuyNowListTile(
      {super.key, required this.title, this.leading, required this.onPressed})
      : isActivated = true;

  const BuyNowListTile.activation({
    super.key,
    required this.title,
    this.leading,
    required this.onPressed,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: leading,
        trailing: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffc2daf8),
            foregroundColor: const Color(0xff023D74),
          ),
          onPressed: (isActivated) ? onPressed : null,
          icon: const Icon(Icons.shopping_cart_outlined),
          label: const Text("Ordina"),
        ));
  }
}
