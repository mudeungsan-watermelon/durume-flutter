import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceOverview extends StatefulWidget {
  const PlaceOverview({super.key});

  @override
  State<PlaceOverview> createState() => _PlaceOverviewState();
}

class _PlaceOverviewState extends State<PlaceOverview> {
  late DatabaseModel dbModel;

  void deleteFavorite(String placeId) {
    dbModel.favoriteProvider!.deleteFavorite(placeId);
    setState(() {});
  }

  void insertFavorite(Favorite favorite) {
    dbModel.favoriteProvider!.insertFavorite(favorite);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    dbModel = Provider.of<DatabaseModel>(context);
    return Consumer<MapModel>(
        builder: (context, provider, child) {
          return SizedBox(
            // height: 220,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      provider.detailInfo!["place_name"],
                      style: TextStyle(
                          fontSize: 24, color: primaryColor, fontWeight: FontWeight.w700
                      ),
                    ),
                    FutureBuilder(
                      future: dbModel.favoriteProvider!.findFavorite(provider.detailInfo!["id"]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return GestureDetector(
                              onTap: (){
                                Fluttertoast.showToast(msg: "잠시만 기다려주세요.");
                              },
                              child: _FavoriteBtn(false)
                          );
                        } else if (snapshot.hasError) {
                          return GestureDetector(
                              onTap: (){
                                Fluttertoast.showToast(msg: "즐겨찾기를 불러올 수 없습니다.");
                              },
                              child: _FavoriteBtn(false)
                          );
                        } else {
                          bool result = snapshot.data as bool;
                          provider.setIsFavorite(result);
                          return GestureDetector(
                            onTap: () async {
                              if (result) {
                                deleteFavorite(provider.detailInfo!["id"]);
                                Fluttertoast.showToast(msg: "즐겨찾기에 삭제되었습니다.");
                              } else {
                                insertFavorite(Favorite(
                                    placeId: provider.detailInfo!["id"],
                                    name: provider.detailInfo!["place_name"],
                                    position: LatLng(double.parse(provider.detailInfo!["y"]), double.parse(provider.detailInfo!["x"]))
                                ));
                                Fluttertoast.showToast(msg: "즐겨찾기에서 추가되었습니다.");
                              }
                              setFavoriteMarkers(dbModel, provider);
                            },
                            child: _FavoriteBtn(provider.isFavorite!)
                          );
                        }
                      }
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      provider.detailInfo!["category_name"],
                      style: TextStyle(
                          fontSize: 14, color: softGrey
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                ReviewOverView(),
                const SizedBox(height: 8,),
                Column(
                  children: [
                    _TextWithCopyBtn("도로명", provider.detailInfo!["road_address_name"]),
                    _TextWithCopyBtn("지번", provider.detailInfo!["address_name"]),
                    _TextWithCopyBtn("전화", provider.detailInfo!["phone"], isPhone: true)
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}

Widget _FavoriteBtn(bool isFavorite) {
  return Padding(
    padding: const EdgeInsets.only(top: 3, left: 4),
    child: Icon(
      Symbols.favorite,
      color: primaryColor,
      size: 24,
      weight: isFavorite ? null : 3000,
      fill: isFavorite ? 1 : null,
    ),
  );
}

Widget _TextWithCopyBtn(String title, String content, {bool isPhone = false}) {
  return Row(
    children: [
      Container(
          color: Color(0xffd9d8d9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
            child: Text(title, style: TextStyle(fontSize: 14, color: softGrey),),
          )
      ),
      const SizedBox(width: 12,),
      Text(content, style: TextStyle(fontSize: 16),),
      isPhone ? _CallMenuBtn(content) :
        Container(
          // width: 20,
          // height: 20,
          child: IconButton(
            // padding: EdgeInsets.zero,
            // constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
              onPressed: (){
                Clipboard.setData(ClipboardData(text: content));
                Fluttertoast.showToast(msg: "주소가 복사되었습니다.");
              },
              icon: Icon(Symbols.content_copy, size: 18, color: primaryColor,)
          ),
        )
    ],
  );
}

Widget _CallMenuBtn(String phone) {
  TextStyle _textStyle = const TextStyle(color: Color(0xff1d1b20), fontSize: 16,);
  return MenuAnchor(
    // childFocusNode: buttonFocusNode,
    style: MenuStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
    alignmentOffset: const Offset(30, 0),
    crossAxisUnconstrained: true,
    menuChildren: [
      Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Column(
          children: <Widget>[
            MenuItemButton(
              child: Text("전화 걸기", style: _textStyle,),
              onPressed: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: phone
                );
                await launchUrl(launchUri);
              },
            ),
            MenuItemButton(
              child: Text("전화번호 저장", style: _textStyle,),
              onPressed: (){},
            ),
            MenuItemButton(
              child: Text("전화번호 복사", style: _textStyle,),
              onPressed: (){
                Clipboard.setData(ClipboardData(text: phone));
                Fluttertoast.showToast(msg: "전화번호가 복사되었습니다.");
              },
            ),
          ],
        ),
      ),
    ],
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: (){
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(Symbols.call, size: 18, color: primaryColor,)
      );
    },
  );
}