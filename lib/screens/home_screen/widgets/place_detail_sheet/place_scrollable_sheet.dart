import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_sheet.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/bottom_sheet_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceScrollableSheet extends StatefulWidget {
  const PlaceScrollableSheet({super.key,});

  @override
  State<PlaceScrollableSheet> createState() => _PlaceScrollableSheetState();
}

class _PlaceScrollableSheetState extends State<PlaceScrollableSheet> {
  final DraggableScrollableController controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    double height = MediaQuery.of(context).size.height;
    controller.addListener(() {
      if (controller.size > 240 / height + 0.1) {
        if (!mapModel.goDetail) {
          showPlaceDetailDialog(context);
          mapModel.setGoDetail();
          controller.reset();
        }
      }
    });
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 240 / height,
      minChildSize: 240 / height,
      maxChildSize: 1,
      snap: true,
      builder: (BuildContext context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: height,
            decoration: basicBoxStyle(borderDirectional: true),
            child: const PlaceSheet(),
          ),
        );
      },
    );
  }
}