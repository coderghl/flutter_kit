import 'dart:async';

import 'package:flutter/material.dart';

import '../../route/route.dart';

class Toast {
  static OverlayEntry? _entry;
  static Timer? _timer;

  static TextStyle toastTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static BoxDecoration toastDecoration = BoxDecoration(
    color: Colors.black.withOpacity(.5),
    borderRadius: BorderRadius.circular(8),
  );

  static EdgeInsets toastPadding = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static Future<void> initStyle({
    TextStyle? textStyle,
    BoxDecoration? decoration,
    EdgeInsets? padding,
  }) async {
    if (textStyle != null) {
      toastTextStyle = textStyle;
    }
    if (decoration != null) {
      toastDecoration = decoration;
    }
    if (padding != null) {
      toastPadding = padding;
    }
  }

  static Future<void> show(String message) async {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;

    final toast = _ToastWidget(
      message: message,
      toastTextStyle: toastTextStyle,
      toastDecoration: toastDecoration,
      toastPadding: toastPadding,
    );
    _entry = OverlayEntry(builder: (context) => toast);

    OverlayState overlay = Navigator.of(
      navigatorKey.currentContext!,
      rootNavigator: true,
    ).overlay!;

    overlay.insert(_entry!);

    _timer = Timer(const Duration(milliseconds: 2800), () {
      _entry?.remove();
      _entry = null;
    });
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.toastTextStyle,
    required this.toastDecoration,
    required this.toastPadding,
  });

  final String message;
  final TextStyle toastTextStyle;
  final BoxDecoration toastDecoration;
  final EdgeInsets toastPadding;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animationAlignmentY = Tween<double>(
    begin: -1,
    end: -.8,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCirc,
  ));

  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCirc,
  ));

  StreamSubscription? _hideSubscription;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        hide();
      }
    });
    _controller.forward();
  }

  void hide() {
    _hideSubscription = Stream.fromFuture(
      Future.delayed(const Duration(seconds: 2)),
    ).listen((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Align(
          alignment: Alignment(0, _animationAlignmentY.value),
          child: FadeTransition(opacity: _opacityAnimation, child: child!),
        );
      },
      child: Container(
        padding: widget.toastPadding,
        decoration: widget.toastDecoration,
        child: DefaultTextStyle(
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
          child: Text(
            widget.message,
            textDirection: TextDirection.ltr,
            style: widget.toastTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideSubscription?.cancel();
    super.dispose();
  }
}
