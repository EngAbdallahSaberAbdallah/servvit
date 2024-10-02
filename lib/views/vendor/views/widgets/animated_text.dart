import 'dart:developer';

import 'package:echo/root/app_root.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/local/cache_helper/cache_keys.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    super.key,
    required this.text,
    required this.style,
    this.width,
  });
  final String text;
  final TextStyle style;
  final double? width;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin, RouteAware {
  late final AnimationController _controller;
  late final ScrollController _scrollController;

  @override
  void didPushNext() {
    super.didPushNext();
    _controller.stop();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _controller.repeat(reverse: true);
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: widget.style,
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: CacheKeysManger.getLanguageFromCache() == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          maxLines: 1,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);
        log('textPainter.width: ${textPainter.width} ,,,, constraints.maxWidth: ${constraints.maxWidth}');
        if (textPainter.width >= constraints.maxWidth.floor()) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_scrollController.hasClients) {
                final offset = _controller.value *
                    (_scrollController.position.maxScrollExtent);
                _scrollController.jumpTo(
                  offset,
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                child: Text(
                  widget.text,
                  overflow: TextOverflow.fade,
                  style: widget.style,
                ),
              );
            },
          );
        }
        return Text(
          widget.text,
          style: widget.style,
        );
      },
    );
  }
}
