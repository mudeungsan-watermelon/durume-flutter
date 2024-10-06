import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class FavoriteBtn extends StatefulWidget {
  FavoriteBtn({
    super.key,
    required this.result
  });

  bool result;

  @override
  State<FavoriteBtn> createState() => _FavoriteBtnState();
}

class _FavoriteBtnState extends State<FavoriteBtn> {
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
    MapModel mapModel = Provider.of<MapModel>(context);
    dbModel = Provider.of<DatabaseModel>(context);
    return GestureDetector(
        onTap: () async {
          if (widget.result) {
            deleteFavorite(mapModel.detailInfo!["id"]);
            Fluttertoast.showToast(msg: "즐겨찾기에 삭제되었습니다.");
          } else {
            insertFavorite(Favorite(
                placeId: mapModel.detailInfo!["id"],
                name: mapModel.detailInfo!["place_name"],
                position: LatLng(double.parse(mapModel.detailInfo!["y"]), double.parse(mapModel.detailInfo!["x"]))
            ));
            Fluttertoast.showToast(msg: "즐겨찾기에서 추가되었습니다.");
          }
          setFavoriteMarkers(dbModel, mapModel);
        },
        child: FavoriteIcon(mapModel.isFavorite!)
    );
  }
}

Widget FavoriteIcon(bool isFavorite) {
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
