import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class OffsetTween extends Tween<Offset?> {
  OffsetTween({Offset? begin, Offset? end}) : super(begin: begin, end: end);

  @override
  Offset? lerp(double t) {
    return Offset(
        Tween(begin: begin!.dx, end: end!.dx).transform(t),
        Tween(begin: begin!.dy, end: end!.dy).transform(t));
  }
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlay;
  late AnimationController _controller;
  OffsetTween? _offsetTween;
  Offset? _currentPosition;
  Offset? _startPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      _currentPosition = _offsetTween!.evaluate(_controller);
      _overlay!.markNeedsBuild();
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

  void _updateStartPosition() {
    if (_startPosition == null) {
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero);

      _startPosition = offset;
      _currentPosition = _startPosition;
    }
  }

  void _runAnimation() {
    _offsetTween = OffsetTween(begin: _currentPosition, end: _startPosition);
    _controller.reset();
    _controller.forward(from: 0);
  }

  void _addOverlay() {
    if (_overlay != null) return;
    _overlay = OverlayEntry(builder: (context) {
      return Positioned(
        top: _currentPosition!.dy,
        left: _currentPosition!.dx,
        child: GestureDetector(
          onPanDown: (details) {
            if (_controller.isAnimating) {
              _currentPosition = _offsetTween!.evaluate(_controller);
              _controller.stop();
            }
          },
          onPanUpdate: (details) {
            _currentPosition = _currentPosition! + details.delta;
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
