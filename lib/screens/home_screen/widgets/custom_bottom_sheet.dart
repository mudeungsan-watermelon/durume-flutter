import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _bottomSheetController;

  late double _height;

  final double _lowLimit = 200;
  final double _highLimit = 600;
  final double _upThresh = 250;
  final double _boundary = 500;
  final double _downThresh = 550;

  bool _longAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomSheetController = AnimationController(
        vsync: this, duration: Duration(seconds: 2)
    );
    _height = _lowLimit;
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
            (_height <= _lowLimit && delta > 0) ||  // low보다 작고 delta가 양수일땐 변화 X
            (_height >= _highLimit && delta < 0)  // high보다 크고 delta가 음수일땐 변화 X
          ) return;
          
          setState(() {
            if (_upThresh <= _height && _height <= _boundary) {  // 위로 휘릭
              _height = _highLimit;
              _longAnimation = true;
            } else if (_boundary <= _height && _height <= _downThresh) {  // 아래로 휘릭
              _height = _lowLimit;
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
        child: SearchResultModal(results: mapModel.results)
      ),
      // child: BottomSheet(
      //   onClosing: () {
      //     mapModel.resetResults();
      //     mapModel.resetHasResults();
      //   },
      //   builder: (context) => SearchResultModal(results: mapModel.results, height: _height),
      //   animationController: _bottomSheetController,
      //   showDragHandle: true,
      // ),
    );
  }
}
