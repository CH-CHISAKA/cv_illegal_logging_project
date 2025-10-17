import 'package:flutter/material.dart';

class ImpressionableButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const ImpressionableButton({
    required this.icon,
    required this.onTap,
    this.size = 40,
    super.key,
  });

  @override
  _ImpressionableButtonState createState() => _ImpressionableButtonState();
}

class _ImpressionableButtonState extends State<ImpressionableButton> {
  bool _hovering = false;
  bool _pressed = false;

  Color get hoverColor => Colors.grey.withValues(alpha: 0.2);
  Color get pressedColor => Colors.grey.withValues(alpha: 0.4);
  Color get iconColor => Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    final showEffect = _pressed || _hovering;
    final currentColor = _pressed
        ? pressedColor
        : (_hovering ? hoverColor : Colors.transparent);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() {
        _hovering = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: currentColor,
            shape: BoxShape.circle,
            boxShadow: showEffect
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: _pressed ? 4 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: AnimatedScale(
            scale: _pressed ? 0.95 : (_hovering ? 1.1 : 1.0),
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Icon(
              widget.icon,
              color: iconColor,
              size: widget.size * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}


