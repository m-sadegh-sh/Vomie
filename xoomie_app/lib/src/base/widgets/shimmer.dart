import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xoomie/src/styling/color_palette.dart';
import 'package:xoomie/src/theme/bloc/theme_bloc.dart';
import 'package:xoomie/src/theme/bloc/theme_state.dart';

typedef ShimmerWidgetBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  Decoration decoration,
);

class Shimmer extends StatefulWidget {
  final BoxShape shape;
  final Duration duration;
  final ShimmerWidgetBuilder builder;

  const Shimmer({
    this.shape = BoxShape.rectangle,
    this.duration = const Duration(seconds: 1),
    required this.builder,
    super.key,
  });

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller),
    );

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeStateBase>(
      builder: (context, state) {
        final isDark = state is ThemeDetectedState ? state.isDark : false;

        final decoration = _createDecoration(
          animation: _animation,
          shape: widget.shape,
          colors: isDark ? darkShimmerColors : lightShimmerColors,
        );

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) =>
              widget.builder(context, child, decoration),
        );
      },
    );
  }

  Decoration _createDecoration({
    required Animation<double> animation,
    required BoxShape shape,
    required List<Color> colors,
  }) {
    return BoxDecoration(
      shape: shape,
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
        stops: [
          animation.value - 1,
          animation.value,
          animation.value + 1,
        ],
      ),
    );
  }
}
