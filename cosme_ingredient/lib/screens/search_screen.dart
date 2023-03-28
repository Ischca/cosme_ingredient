import 'package:flutter/cupertino.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';
import 'package:cosme_ingredient/widgets/cosmetic_card.dart';

class SearchScreen extends StatefulWidget {
  final String searchTerm;

  SearchScreen({required this.searchTerm});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Cosmetic> searchResults = [];

  @override
  void initState() {
    super.initState();
    // Search for cosmetics and ingredients with the searchTerm
    // For now, we use an empty list as a placeholder
    searchResults = [
      Cosmetic(id: '0', name: 'ファンデーション', brand: 'クレドポーボーテ', imageUrl: '', ingredients: '水,ジメチコン,酸化チタン,ジフェニルシロキシフェニルトリメチコン,グリセリン,ＤＰＧ,メトキシケイヒ酸エチルヘキシル,ＢＧ,ＰＥＧ－１０ジメチコン,ＰＥＧ－２０,ラウリルＰＥＧ－９ポリジメチルシロキシエチルジメチコン,ＰＥＧ－６,ＰＥＧ－３２,ジステアルジモニウムヘクトライト,（ジフェニルジメチコン／ビニルジフェニルジメチコン／シルセスキオキサン）クロスポリマー,（ジメチコン／ビニルジメチコン）クロスポリマー,水添ポリイソブテン,トレハロース,アルガニアスピノサ核油,ＰＥＧ／ＰＰＧ－１４／７ジメチルエーテル,グリシン,トルメンチラ根エキス,トリメチルシロキシケイ酸,イザヨイバラエキス,トウキ根エキス,加水分解シルク,加水分解コンキオリン,シソ葉エキス,ベヘン酸,リンゴ酸ジイソステアリル,セスキイソステアリン酸ソルビタン,水酸化Ａｌ,（ジメチコン／フェニルビニルジメチコン）クロスポリマー,トリエトキシカプリリルシラン,ＥＤＴＡ－３Ｎａ,ステアリン酸,テトラヒドロテトラメチルシクロテトラシロキサン,トリエトキシシリルエチルポリジメチルシロキシエチルジメチコン,テトラデセン,ＢＨＴ,シリカ,テアニン,トコフェロール,タルク,ポリメチルシルセスキオキサン,ハイドロゲンジメチコン,メチルパラベン,エチルパラベン,香料,酸化鉄,硫酸Ｂａ,合成金雲母,マイカ')
    ]; // 仮の検索結果を設定します
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Search results for "${widget.searchTerm}"'),
      ),
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final cosmetic = searchResults[index];
          return CosmeticCard(cosmetic: cosmetic);
        },
      ),
    );
  }
}
