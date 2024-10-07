import 'package:durume_flutter/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
    required this.lowLimit,
    required this.highLimit,
    required this.upThresh,
    required this.boundary,
    required this.downThresh,
    required this.childWidget,
  });

  late double lowLimit;
  late double highLimit;
  late double upThresh;
  late double boundary;
  late double downThresh;
  late Widget childWidget;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _bottomSheetController;

  late double _height;

  // final double _lowLimit = 300;
  // final double _highLimit = 900;
  // final double _upThresh = 350;
  // final double _boundary = 500;
  // final double _downThresh = 850;

  bool _longAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomSheetController = AnimationController(
        vsync: this, duration: Duration(seconds: 2)
    );
    _height = widget.lowLimit;
  }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return GestureDetector(
      onVerticalDragUpdate: ((details) {
        // y축의 변화량. 위 -> + / 아래 -> -
        double? delta = details.primaryDelta;
        if (delta != null) {
          if (
            _longAnimation ||  // Long Animation 진행중에는 높이 변화 X
            (_height <= widget.lowLimit && delta > 0) ||  // low보다 작고 delta가 양수일땐 변화 X
            (_height >= widget.highLimit && delta < 0)  // high보다 크고 delta가 음수일땐 변화 X
          ) return;
          
          setState(() {
            if (widget.upThresh <= _height && _height <= widget.boundary) {  // 위로 휘릭
              _height = widget.highLimit;
              _longAnimation = true;
            } else if (widget.boundary <= _height && _height <= widget.downThresh) {  // 아래로 휘릭
              _height = widget.lowLimit;
              _longAnimation = true;
            } else {  // 기본 작동
              _height -= delta;
            }
          });
        }
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _height,
        // curve: Curves.bounceOut,
        onEnd: () {
          if (_longAnimation) {
            setState(() {
              _longAnimation = false;
            });
          }
        },
        color: Colors.white,
        child: widget.childWidget,
      ),
    );
  }
}
