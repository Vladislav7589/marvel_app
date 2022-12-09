
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/providers/database_provider.dart';
import 'package:marvel_app/src/widgets/hero_card.dart';
import '../../constants.dart';
import '../../translations/locale_keys.g.dart';
import '../providers/dio_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/shimmer.dart';

class HeroDetails extends ConsumerWidget {
  final int? heroId;
  final int? heroDb;

  const HeroDetails({Key? key, required this.heroId, this.heroDb})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
        body: heroId != null ? ref.watch(fetchHeroInfo(heroId!)).when(
            data: (data) => HeroCard(hero: data, details: true,),
            error: (error, stack) =>
             NetworkErrorWidget(text: LocaleKeys.errorsErrorLoadData.tr()),
            loading: () =>
                Container(
                    color: backgroundColor,
                    child: const ShimmerWidget())
        ) : ref.watch(dataHero(heroDb!)).when(
            data: (data) => HeroCard(heroDB: data, details: true),
            error: (error, stack) =>
            NetworkErrorWidget(text: LocaleKeys.errorsErrorLoadDatabase.tr()),
            loading: () =>
                Container(
                    color: backgroundColor,
                    child: const ShimmerWidget())
        )

    );
  }
}