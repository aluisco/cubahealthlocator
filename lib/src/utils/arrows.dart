import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArrowsPage extends StatefulWidget {
  const ArrowsPage({super.key});

  @override
  State<ArrowsPage> createState() => _ArrowsPageState();
}

class _ArrowsPageState extends State<ArrowsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedIcon(
                icon: AnimatedIcons.arrow_menu,
                progress: animation,
                color: Colors.white),
            Text(
              AppLocalizations.of(context)!.swipe,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedIcon(
              icon: AnimatedIcons.arrow_menu,
              progress: animation,
              color: Colors.white,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
