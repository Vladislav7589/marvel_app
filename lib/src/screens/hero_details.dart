
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/providers/database_provider.dart';
import 'package:marvel_app/src/widgets/hero_card.dart';
import '../../translations/locale_keys.g.dart';
import '../providers/dio_provider.dart';
import '../widgets/shimmer.dart';

class HeroDetails extends ConsumerWidget {
  final int? heroId;
  final int? heroDb;

  const HeroDetails({Key? key, required this.heroId, this.heroDb})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
        body: heroId != null ? ref.watch(fetchHeroInfo(heroId!)).when(
            data: (data) => HeroCard(hero: data, details: true,),
            error: (error, stack) =>
             Center(child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
               children: [
                 Text(LocaleKeys.errorsErrorLoadData.tr(),textAlign:TextAlign.center, style: const TextStyle(fontSize: 25 , color:
                 Colors.red,fontWeight: FontWeight.bold),),
                 const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                 CircleAvatar(
                   backgroundColor: Colors.red,
                   child: IconButton(onPressed: (){
                     return ref.refresh(fetchHeroInfo(heroId!).future);
                   }, icon: const Icon(Icons.update,color: Colors.black,)),
                 )
               ],
             )),
            loading: () =>
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: const ShimmerWidget())
        ) : ref.watch(dataHero(heroDb!)).when(
            data: (data) => HeroCard(heroDB: data, details: true),
            error: (error, stack) =>
                Center(child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.errorsErrorLoadDatabase.tr(),textAlign:TextAlign.center, style: const TextStyle(fontSize: 25 , color:
                    Colors.red,fontWeight: FontWeight.bold),),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(onPressed: (){
                        return ref.refresh(dataHero(heroDb!).future);
                      }, icon: const Icon(Icons.update,color: Colors.black,)),
                    )
                  ],
                )),
            loading: () =>
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: const ShimmerWidget())
        )

    );
  }
}