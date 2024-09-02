import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget BarrierFreeInfoList() {
  return Column(
    children: [
      Row(
      children: [
          Text("무장애 정보", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
          SizedBox(width: 4,),
          Icon(Symbols.info, size: 18,)
        ],
      ),
      SizedBox(height: 14,),
      Column(
        children: [
          _BarrierFreeInfo(text: "휠체어 사용 가능", icon: Symbols.accessible_forward),
          _BarrierFreeInfo(text: "휠체어 사용 가능", icon: Symbols.accessible_forward),
          _BarrierFreeInfo(text: "휠체어 사용 가능", icon: Symbols.accessible_forward),
        ]
      )
    ]
  );
}

Widget _BarrierFreeInfo({String text = "", IconData icon = Symbols.accessible_forward}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 11),
    child: Row(
      children: [
        Icon(icon, size: 32),
        SizedBox(width: 8,),
        Text(text, style: TextStyle(fontSize: 18),),
      ],
    ),
  );
}