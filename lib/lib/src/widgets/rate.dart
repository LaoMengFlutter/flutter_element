import 'package:flutter/material.dart';
import 'theme/rate_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

typedef LabelWidgetBuilder = Widget Function(double value);

const Color _kActiveColor = Colors.amber;

class ERate extends StatefulWidget {
  final double value;
  final ERateStyle? style;
  final ValueChanged<double>? onChanged;
  final int count;
  final Widget? child;
  final RateIconType iconType;
  final IndexedWidgetBuilder? itemBuilder;
  final double itemSize;
  final double space;
  final bool enable;
  final bool showLabel;
  final TextStyle? labelTextStyle;
  final LabelWidgetBuilder? labelBuilder;

  const ERate({
    Key? key,
    required this.value,
    this.style,
    this.onChanged,
    this.count = 5,
    this.child,
    this.itemBuilder,
    this.itemSize = 40,
    this.iconType = RateIconType.star,
    this.space = 6,
    this.enable = true,
    this.showLabel = false,
    this.labelTextStyle,
    this.labelBuilder,
  })  : assert(0 <= value),
        assert(0 < count),
        assert(value <= count),
        super(key: key);

  @override
  _ERateState createState() => _ERateState();
}

class _ERateState extends State<ERate> {
  late double _value;

  @override
  initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ERate oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.rateStyle?.merge(widget.style) ?? widget.style;

    Color activeColor = _style?.activeColor ?? _kActiveColor;
    Color inactiveColor = _style?.inactiveColor ??
        eleTheme.borderColorLighter ??
        Colors.transparent;

    List<Widget> children = [];
    List.generate(widget.count, (index) {
      var child = widget.itemBuilder?.call(context, index) ??
          widget.child ??
          _getItemByIconType(widget.iconType, index, _value);

      if (index < _value.floor()) {
        children.add(_buildItem(index, activeColor, widget.itemSize, child));
      } else if (index >= _value.floor() && index < _value.ceil()) {
        children.add(_buildMixItem(index, _value - _value.floor(), activeColor,
            inactiveColor, widget.itemSize, child));
      } else {
        children.add(_buildItem(index, inactiveColor, widget.itemSize, child));
      }

      if (index < widget.count - 1) {
        children.add(_buildSpace());
      }
    });
    if (widget.showLabel) {
      children.add(_buildSpace());
      var label = widget.labelBuilder?.call(_value) ??
          Text(
            '$_value',
            style: widget.labelTextStyle,
          );
      children.add(label);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  _onTap(int index) {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = index.toDouble() + 1;
    });
  }

  Widget _buildItem(int index, Color color, double size, Widget child) {
    var item = _ItemView(
      color: color,
      size: size,
      child: child,
    );
    if (widget.enable) {
      return _ItemScale(
        onTap: () {
          _onTap(index);
        },
        child: item,
      );
    }
    return item;
  }

  Widget _buildMixItem(int index, double percentage, Color activeColor,
      Color inactiveColor, double size, Widget child) {
    var item = _ItemPercentageView(
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      percentage: percentage,
      size: size,
      child: child,
    );
    if (widget.enable) {
      return _ItemScale(
        onTap: () {
          _onTap(index);
        },
        child: item,
      );
    }
    return item;
  }

  Widget _buildSpace() {
    return SizedBox(width: widget.space);
  }

  Widget _getItemByIconType(RateIconType iconType, int index, double value) {
    IconData? iconData;
    switch (iconType) {
      case RateIconType.star:
        iconData = Icons.star;
        break;
      case RateIconType.sentiment:
        if (index == 0) {
          iconData = Icons.sentiment_very_dissatisfied;
        } else if (index == 1) {
          iconData = Icons.sentiment_dissatisfied;
        } else if (index == 2) {
          iconData = Icons.sentiment_neutral;
        } else if (index == 3) {
          iconData = Icons.sentiment_satisfied;
        } else if (index == 4) {
          iconData = Icons.sentiment_satisfied_alt;
        }
        break;
      case RateIconType.sameSentiment:
        int v = value.round();
        switch (v) {
          case 0:
            iconData = Icons.sentiment_very_dissatisfied;
            break;
          case 1:
            iconData = Icons.sentiment_very_dissatisfied;
            break;
          case 2:
            iconData = Icons.sentiment_dissatisfied;
            break;
          case 3:
            iconData = Icons.sentiment_neutral;
            break;
          case 4:
            iconData = Icons.sentiment_satisfied;
            break;
          case 5:
            iconData = Icons.sentiment_satisfied_alt;
            break;
        }
        break;
    }
    return Icon(iconData);
  }
}

enum RateIconType {
  star,
  sentiment,
  sameSentiment,
}

class _ItemView extends StatelessWidget {
  final Color color;
  final Widget child;
  final double size;

  const _ItemView({
    Key? key,
    required this.color,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: FittedBox(
          child: child,
        ),
      ),
    );
  }
}

class _ItemPercentageView extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;
  final double percentage;
  final Widget child;
  final double size;

  const _ItemPercentageView({
    Key? key,
    required this.activeColor,
    required this.inactiveColor,
    required this.percentage,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: _ItemView(
              color: activeColor,
              child: child,
              size: size,
            ),
          ),
          Positioned.fill(
            child: ClipRect(
              clipper: _PercentageClipper(percentage: percentage),
              child: _ItemView(
                color: inactiveColor,
                child: child,
                size: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PercentageClipper extends CustomClipper<Rect> {
  _PercentageClipper({required this.percentage});

  final double percentage;

  @override
  Rect getClip(Size size) => Rect.fromLTRB(
        size.width * percentage,
        0.0,
        size.width,
        size.height,
      );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class _ItemScale extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;

  const _ItemScale({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  __ItemScaleState createState() => __ItemScaleState();
}

class __ItemScaleState extends State<_ItemScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween<double>(begin: 1, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (_controller.status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      },
      onTapUp: (details) {
        if (_controller.status == AnimationStatus.completed ||
            _controller.status == AnimationStatus.forward) {
          _controller.reverse();
        }
        widget.onTap?.call();
      },
      onTapCancel: () {
        if (_controller.status == AnimationStatus.completed ||
            _controller.status == AnimationStatus.forward) {
          _controller.reverse();
        }
      },
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
