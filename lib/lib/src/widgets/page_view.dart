import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'theme/page_view_style.dart';
import 'theme/theme.dart';

const _kAutoPlayDuration = Duration(milliseconds: 3000);
const _kNextPageDuration = Duration(milliseconds: 300);
const _kDotIndicatorSize = Size(8, 8);
const _kHorizontalLineIndicatorSize = Size(24, 2);
const _kVerticalLineIndicatorSize = Size(2, 24);
const _kIndicatorPadding = EdgeInsets.all(6);

class EPageView extends StatefulWidget {
  const EPageView({
    Key? key,
    this.initialPage = 0,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollDirection = Axis.horizontal,
    this.autoPlay = false,
    this.autoPlayDuration = _kAutoPlayDuration,
    this.nextPageDuration = _kNextPageDuration,
    this.loop = false,
    this.showIndicator = false,
    this.indicatorItemBuilder,
    this.indicatorType = PageViewIndicatorType.dot,
    this.indicatorPosition = PageViewIndicatorPosition.inside,
    this.indicatorAlignment = Alignment.center,
    this.indicatorSize,
    this.style,
    this.indicatorPadding = _kIndicatorPadding,
    this.type = PageViewType.normal,
    this.viewportFraction = 1.0,
    this.cardScale = 0.8,
    this.showControl,
    this.nextWidget,
    this.previousWidget,
  }) : super(key: key);
  final int initialPage;
  final IndexedWidgetBuilder itemBuilder;
  final bool showIndicator;
  final IndexedWidgetBuilder? indicatorItemBuilder;
  final PageViewIndicatorType indicatorType;
  final PageViewIndicatorPosition indicatorPosition;
  final Alignment indicatorAlignment;
  final Size? indicatorSize;
  final EdgeInsetsGeometry? indicatorPadding;
  final int itemCount;
  final Axis scrollDirection;
  final PageViewType type;
  final double viewportFraction;
  final double cardScale;

  //自动切换
  final bool autoPlay;

  //自动切换间隔
  final Duration autoPlayDuration;

  //自动切换，切换Page时长
  final Duration nextPageDuration;

  //是否无限循环
  final bool loop;

  final EPageViewStyle? style;

  /// 是否显示控制按钮 [nextWidget] 和 [previousWidget],除android 和ios其他平台默认显示
  final bool? showControl;

  /// 下一个按钮，
  final Widget? nextWidget;

  /// 上一个按钮
  final Widget? previousWidget;

  @override
  State<EPageView> createState() => _EPageViewState();
}

class _EPageViewState extends State<EPageView> {
  Timer? _timer;
  late PageController _controller;
  double _pageIndex = 0;
  late bool _showControl;

  EPageViewStyle? get _style =>
      EleTheme.of(context).pageViewStyle?.merge(widget.style) ?? widget.style;

  @override
  initState() {
    if (widget.autoPlay) {
      _initTimer();
    }
    _pageIndex = widget.initialPage.toDouble();
    _controller = PageController(
      initialPage: widget.initialPage,
      viewportFraction: widget.viewportFraction,
    )..addListener(() {
        setState(() {
          _pageIndex = _controller.page ?? 0.0;
        });
      });

    _showControl =
        widget.showControl ?? !(Platform.isIOS || Platform.isAndroid);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EPageView oldWidget) {
    if (oldWidget.initialPage != widget.initialPage ||
        oldWidget.viewportFraction != widget.viewportFraction) {
      _pageIndex = widget.initialPage.toDouble();
      _controller = PageController(
        initialPage: widget.initialPage,
        viewportFraction: widget.viewportFraction,
      )..addListener(() {
          setState(() {
            _pageIndex = _controller.page ?? 0.0;
          });
        });
    }
    if (oldWidget.showControl != widget.showControl) {
      _showControl =
          widget.showControl ?? !(Platform.isIOS || Platform.isAndroid);
    }
    super.didUpdateWidget(oldWidget);
  }

  _initTimer() {
    _timer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (!widget.loop && _controller.page! >= widget.itemCount - 1) {
        return;
      }
      _controller.nextPage(
          duration: widget.nextPageDuration, curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _pageView = _buildPageView();
    if (widget.showIndicator) {
      Widget _indicatorWidget = _buildIndicatorView();
      switch (widget.indicatorPosition) {
        case PageViewIndicatorPosition.inside:
          _pageView = Stack(
            children: [
              Positioned.fill(child: _pageView),
              if (widget.scrollDirection == Axis.vertical)
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: _indicatorWidget,
                ),
              if (widget.scrollDirection == Axis.horizontal)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: _indicatorWidget,
                ),
            ],
          );
          break;
        case PageViewIndicatorPosition.outside:
          if (widget.scrollDirection == Axis.vertical) {
            _pageView = Row(
              children: [Expanded(child: _pageView), _indicatorWidget],
            );
          } else {
            _pageView = Column(
              children: [Expanded(child: _pageView), _indicatorWidget],
            );
          }
          break;
      }
    }

    if (_showControl) {
      _pageView = Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: _pageView),
          if (widget.scrollDirection == Axis.horizontal)
            Positioned(
              bottom: 0,
              left: 12,
              top: 0,
              child: _buildPreviousWidget(Icons.keyboard_arrow_left_outlined),
            ),
          if (widget.scrollDirection == Axis.horizontal)
            Positioned(
              bottom: 0,
              right: 12,
              top: 0,
              child: _buildNextWidget(Icons.keyboard_arrow_right_outlined),
            ),
          if (widget.scrollDirection == Axis.vertical)
            Positioned(
              bottom: 12,
              right: 0,
              left: 0,
              child: _buildNextWidget(Icons.expand_more),
            ),
          if (widget.scrollDirection == Axis.vertical)
            Positioned(
              top: 12,
              right: 0,
              left: 0,
              child: _buildPreviousWidget(Icons.expand_less),
            ),
        ],
      );
    }
    return _pageView;
  }

  _nextPage() {
    _controller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  _previousPage() {
    _controller.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget _buildNextWidget(IconData iconData) {
    return GestureDetector(
      onTap: _nextPage,
      child: Center(
        child: widget.nextWidget ??
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EleTheme.of(context).borderColorBase),
              child: Icon(iconData,
                  color: EleTheme.of(context).backgroundColorWhite),
            ),
      ),
    );
  }

  Widget _buildPreviousWidget(IconData iconData) {
    return GestureDetector(
      onTap: _previousPage,
      child: Center(
        child: widget.previousWidget ??
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EleTheme.of(context).borderColorBase),
              child: Icon(iconData,
                  color: EleTheme.of(context).backgroundColorWhite),
            ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        if (widget.type == PageViewType.card) {
          return _buildCardPageItem(index);
        }
        return widget.itemBuilder(context, index % widget.itemCount);
      },
      itemCount: widget.loop ? null : widget.itemCount,
      scrollDirection: widget.scrollDirection,
    );
  }

  _buildCardPageItem(int index) {
    double currScale = widget.cardScale;
    if (index == _pageIndex.floor()) {
      //当前的item
      currScale = 1 - (_pageIndex - index) * (1 - widget.cardScale);
    } else if (index == _pageIndex.floor() + 1) {
      //右边的item
      currScale =
          widget.cardScale + (_pageIndex - index + 1) * (1 - widget.cardScale);
    } else if (index == _pageIndex.floor() - 1) {
      //左边
      currScale = 1 - (_pageIndex - index) * (1 - widget.cardScale);
    }
    return Transform.scale(
      scale: currScale,
      child: widget.itemBuilder(context, index % widget.itemCount),
    );
  }

  Widget _buildIndicatorView() {
    if (widget.indicatorItemBuilder != null) {
      return widget.indicatorItemBuilder!
          .call(context, _pageIndex.floor() % widget.itemCount);
    }
    return _IndicatorView(
      index: _pageIndex.floor() % widget.itemCount,
      count: widget.itemCount,
      type: widget.indicatorType,
      alignment: widget.indicatorAlignment,
      direction: widget.scrollDirection,
      color: _style?.indicatorColor ??
          EleTheme.of(context).backgroundColorWhite ??
          Colors.transparent,
      activeColor: _style?.indicatorActiveColor ??
          EleTheme.of(context).primaryColor ??
          Colors.transparent,
      size: widget.indicatorSize ??
          (widget.indicatorType == PageViewIndicatorType.dot
              ? _kDotIndicatorSize
              : (widget.scrollDirection == Axis.horizontal
                  ? _kHorizontalLineIndicatorSize
                  : _kVerticalLineIndicatorSize)),
      padding: widget.indicatorPadding,
    );
  }
}

class _IndicatorView extends StatelessWidget {
  const _IndicatorView({
    Key? key,
    this.index = 0,
    required this.count,
    required this.direction,
    required this.alignment,
    required this.color,
    required this.activeColor,
    required this.size,
    required this.type,
    this.padding,
  }) : super(key: key);
  final int count;
  final int index;
  final Axis direction;
  final Alignment alignment;
  final Color activeColor;
  final Color color;
  final Size size;
  final EdgeInsetsGeometry? padding;
  final PageViewIndicatorType type;

  @override
  Widget build(BuildContext context) {
    var _children = List.generate(count, (i) {
      return type == PageViewIndicatorType.dot
          ? _DotIndicatorView(
              color: index == i ? activeColor : color,
              size: size,
            )
          : _LineIndicatorView(
              color: index == i ? activeColor : color,
              size: size,
            );
    }).toList();
    return Container(
      alignment: alignment,
      padding: padding,
      child: Wrap(
        spacing: 6,
        direction: direction,
        children: _children,
      ),
    );
  }
}

class _DotIndicatorView extends StatelessWidget {
  const _DotIndicatorView({Key? key, required this.color, required this.size})
      : super(key: key);

  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _LineIndicatorView extends StatelessWidget {
  const _LineIndicatorView({Key? key, required this.color, required this.size})
      : super(key: key);

  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: color,
    );
  }
}

enum PageViewType {
  //默认样式
  normal,
  //卡片样式
  card,
}

enum PageViewIndicatorType {
  //圆点
  dot,
  //直线
  line,
}
enum PageViewIndicatorPosition {
  //外部
  outside,
  //内部
  inside,
}
