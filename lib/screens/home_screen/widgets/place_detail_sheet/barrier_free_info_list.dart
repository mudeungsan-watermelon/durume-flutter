import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/barrier_free_info.dart';
import 'package:durume_flutter/utils/gemini_model_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarrierFreeInfoList extends StatelessWidget {
  const BarrierFreeInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return FutureBuilder(
      future: getBarrierFreeInfo(
        mapModel.geminiModel,
        mapModel.geminiChatSession,
        placeName: mapModel.detailInfo!["place_name"],
        addressName: mapModel.detailInfo!["address_name"]
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BarrierFreeInfo(isLoading: true,);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return BarrierFreeInfo();
        } else {
          Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          // print(data.toString());

          if (data.isNotEmpty) {
            return BarrierFreeInfo(barrierFreeInfo: data);
          }
          return BarrierFreeInfo();
        }
      }
    );
    // return BarrierFreeInfo(barrierFreeInfo: data);
  }
}
