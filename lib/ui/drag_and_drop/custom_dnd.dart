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
  late AnimationController _controller;
  OffsetTween? _offsetTween;
  Offset _currentPosition = Offset.zero;
  Offset _startPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      _currentPosition = _offsetTween!.evaluate(_controller)!;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation() {
    _offsetTween = OffsetTween(begin: _currentPosition, end: _startPosition);
    _controller.reset();
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        if (_controller.isAnimating) {
          _currentPosition = _offsetTween!.evaluate(_controller)!;
          _controller.stop();
        }
      },
      onPanUpdate: (details) {
        _currentPosition = _currentPosition + details.delta;
        setState(() {});
      },
      onPanEnd: (details) {
        _runAnimation();
      },
      child: Transform.translate(offset: _currentPosition, child: widget.child),
    );
  }
}
