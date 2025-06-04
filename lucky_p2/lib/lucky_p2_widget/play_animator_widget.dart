import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';

class PlayAnimatorWidget extends LuckyBaseStateful{
  Widget child;
  PlayAnimatorWidget({
    required this.child,
});

  @override
  State<StatefulWidget> createState() => PlayAnimatorWidgetState();
}

class PlayAnimatorWidgetState extends LuckyBaseState<PlayAnimatorWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset _startOffset = Offset.zero;
  Offset _endOffset = Offset.zero;
  bool _isFlyingOut = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (_, __) {
      if (!_isVisible) return const SizedBox.shrink();
      // 正在飞行中
      if (_controller.isAnimating) {
        final offset = _getParabolaOffset(_animation.value);
        return Transform.translate(
          offset: offset,
          child: widget.child,
        );
      }
      // 飞入后，停在原位显示
      if (!_isFlyingOut) {
        return widget.child;
      }
      return const SizedBox.shrink();
    },
  );

  Offset _getParabolaOffset(double t) {
    double x = _startOffset.dx + (_endOffset.dx - _startOffset.dx) * t;
    double y = _startOffset.dy + (_endOffset.dy - _startOffset.dy) * t - 50 * t * (1 - t);
    return Offset(x, y);
  }

  void _flyOut() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _isFlyingOut = true;
      _isVisible = true;
      _startOffset = const Offset(0, 0);
      // _endOffset = Offset(-screenWidth, -200);
      _endOffset = Offset(-screenWidth, 0);
    });
    _controller.forward().then((value) {
      setState(() {
        _isVisible = false;
        _controller.reset();
      });
      _flyIn();
    });
  }

  void _flyIn() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _isFlyingOut = false;
      _isVisible = true;
      // _startOffset = Offset(screenWidth, -200);
      _startOffset = Offset(screenWidth, 0);
      _endOffset = const Offset(0, 0);
    });
    _controller.forward().then((_) {
      _controller.reset();
    });
  }

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.flyOut:
        _flyOut();
        break;
      // case P1LuckyEventCode.flyIn:
      //   _flyIn();
      //   break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
