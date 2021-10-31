import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class DraggableCard<T extends Object> extends StatefulWidget {
  const DraggableCard({required this.child, this.data, Key? key}) : super(key: key);

  final Widget child;
  final T? data;

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

class _DraggableCardState<T extends Object> extends State<DraggableCard<T>>
    with SingleTickerProviderStateMixin {
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
    _controller.forward();
  }

  Offset _getGlobalPosition() {
    final box = context.findRenderObject() as RenderBox;
    final globalPosition = box.localToGlobal(Offset.zero);
    return globalPosition + _localPosition;
  }

  void finishDrag() {
    final hit = _getDropTargetHit();

    if (hit != null) {
      final result = hit.drop(widget.data);
      if (result == DropResult.Accepted) {
        _localPosition = Offset.zero;
        setState(() {});
        return;
      }
    }

    _runAnimation();
  }

  _DropTargetState? _getDropTargetHit() {
    final HitTestResult result = HitTestResult();
    WidgetsBinding.instance!.hitTest(result, _getGlobalPosition());
    final List<_DropTargetState> res = [];

    for (final HitTestEntry entry in result.path) {
      final HitTestTarget target = entry.target;
      if (target is RenderMetaData) {
        final dynamic metaData = target.metaData;
        if (metaData is _DropTargetState && metaData.isExpectedDataType(widget.data, T))
          return metaData;
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
        onPanEnd: (details) => finishDrag(),
        child: widget.child,
      ),
    );
  }
}

class DropTarget<T extends Object> extends StatefulWidget {
  const DropTarget({
    Key? key,
    required this.builder,
    this.willAccept,
    this.onAccept,
  }) : super(key: key);

  final Widget Function(BuildContext context) builder;
  final bool Function(T? data)? willAccept;
  final void Function(T? data)? onAccept;

  @override
  _DropTargetState createState() => _DropTargetState();
}

class _DropTargetState<T extends Object> extends State<DropTarget<T>> {
  bool isExpectedDataType(Object? data, Type type) => data is T?;

  DropResult drop(Object? data) {
    if (!mounted) return DropResult.Failed;

    if (widget.willAccept?.call(data as T) ?? true) {
      widget.onAccept?.call(data as T);
      return DropResult.Accepted;
    } else {
      return DropResult.Declined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MetaData(metaData: this, child: widget.builder(context));
  }
}

enum DropResult { Accepted, Declined, Failed }
