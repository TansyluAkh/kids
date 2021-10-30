import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class AnimationOffset {
  Tween<double>? dx;
  Tween<double>? dy;

  AnimationOffset(Offset from, Offset to) {
    dx = Tween(begin: from.dx, end: to.dx);
    dy = Tween(begin: from.dy, end: to.dy);
  }

  Offset evaluate(AnimationController controller) {
    return Offset(dx!.evaluate(controller), dy!.evaluate(controller));
  }
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlay;
  late AnimationController _controller;
  AnimationOffset? _animationOffset;
  Offset? _draggingPosition;
  Offset? _startPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      _overlay!.markNeedsBuild();
    });
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          _draggingPosition = _animationOffset!.evaluate(_controller);
          _animationOffset = null;
          break;
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _updateStartPosition();
      _addOverlay();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlay!.remove();
    _overlay = null;
    super.dispose();
  }

  Offset _getCurrentPosition() {
    if (_controller.isAnimating)
      return _animationOffset?.evaluate(_controller) ?? AnimationOffset(_draggingPosition!, _startPosition!).evaluate(_controller);
    else
      return _draggingPosition ?? Offset.zero;
  }

  void _updateStartPosition() {
    if (_startPosition == null) {
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero);

      _startPosition = offset;
      _draggingPosition = _startPosition;
    }
  }

  void _runAnimation() {
    _animationOffset = AnimationOffset(_getCurrentPosition(), _startPosition!);
    _controller.reset();
    _controller.forward(from: 0);
  }

  void _addOverlay() {
    if (_overlay != null) return;
    _overlay = OverlayEntry(
        builder: (context) {
          final currentPosition = _getCurrentPosition();
          return Positioned(
              top: currentPosition.dy,
              left: currentPosition.dx,
              child: GestureDetector(
                onPanDown: (details) {
                  if (_controller.isAnimating) _controller.reset();
                },
                onPanUpdate: (details) {
                  _draggingPosition = _draggingPosition! + details.delta;
                  _overlay!.markNeedsBuild();
                },
                onPanEnd: (details) {
                  _runAnimation();
                },
                child: widget.child,
              ),
            );
        });

    Overlay.of(context)!.insert(_overlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
