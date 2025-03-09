import 'package:flutter/material.dart';

class LoaderIndicator extends StatelessWidget {
  final Color? color;
  const LoaderIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? Theme.of(context).colorScheme.primary),
    );
  }
}
