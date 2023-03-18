import 'package:flutter/material.dart';
import 'package:tinstgrame/views/components/animations/empty_contents_animation_view.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white54,
                ),
          ),
          const EmptyContentsAnimationView(),
        ],
      ),
    );
  }
}
