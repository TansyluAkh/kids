import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
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
    return Offset(Tween(begin: begin!.dx, end: end!.dx).transform(t),
        Tween(begin: begin!.dy, end: end!.dy).transform(t));
  }
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<Offset?>? _animation;
  Offset _localPosition = Offset.zero;

  bool get isDragging => _localPosition == Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      _localPosition = _animation!.value!;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation() {
    _animation = OffsetTween(begin: _localPosition, end: Offset.zero).animate(_controller);
    _controller.reset();
    _controller.forward(from: 0);
  }

  Offset _getGlobalPosition() {
    final box = context.findRenderObject() as RenderBox;
    final globalPosition = box.localToGlobal(Offset.zero);
    return globalPosition + _localPosition;
  }

  void checkTargets() {
    final HitTestResult result = HitTestResult();
    WidgetsBinding.instance!.hitTest(result, _getGlobalPosition());
    for (final HitTestEntry entry in result.path) {
      final HitTestTarget target = entry.target;
      if (target is RenderMetaData) {
        final dynamic metaData = target.metaData;
        //metaData._.onAccept(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _localPosition,
      child: GestureDetector(
        onPanDown: (details) {
          if (_controller.isAnimating) {
            _localPosition = _animation!.value!;
            _controller.stop();
          }
        },
        onPanUpdate: (details) {
          _localPosition = _localPosition + details.delta;
          setState(() {});
        },
        onPanEnd: (details) {
          checkTargets();
          _runAnimation();
        },
        child: widget.child,
      ),
    );
  }
}
