import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlay;
  bool isAnimating = false;
  late AnimationController _controller;
  Offset? _currentPosition;
  Offset? _startPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed || status == AnimationStatus.completed) {
        _controller.reset();
        _currentPosition = _startPosition;
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

  void _updateStartPosition() {
    if (_startPosition == null) {
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero);

      _startPosition = offset;
      _currentPosition = _startPosition;
    }
  }

  void _addOverlay() {
    if (_overlay != null) return;
    _overlay = OverlayEntry(
        builder: (context) => AnimatedBuilder(
              animation: _controller,
              builder: (ctx, _) => Positioned(
                top: isAnimating
                    ? Tween(begin: _currentPosition!.dy, end: _startPosition!.dy)
                        .evaluate(_controller)
                    : _currentPosition?.dy ?? 0,
                left: isAnimating
                    ? Tween(begin: _currentPosition!.dx, end: _startPosition!.dx)
                        .evaluate(_controller)
                    : _currentPosition?.dx ?? 0,
                child: GestureDetector(
                  onPanDown: (details) {
                    isAnimating = false;
                    _controller.stop();
                    _controller.reset();
                  },
                  onPanUpdate: (details) {
                    isAnimating = false;
                    _currentPosition = _currentPosition! + details.delta;
                    _overlay!.markNeedsBuild();
                  },
                  onPanEnd: (details) {
                    _controller.forward();
                    isAnimating = true;
                  },
                  child: widget.child,
                ),
              ),
            ));

    Overlay.of(context)!.insert(_overlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
