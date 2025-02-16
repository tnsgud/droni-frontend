import 'package:droni/features/user_home/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gap/gap.dart';

import 'package:droni/shared/utils/api_client.dart';
import 'package:droni/shared/widgets/svg_icon.dart';
import 'package:droni/shared/constants/app_colors.dart';
import 'package:droni/shared/constants/text_style.dart';

import 'package:droni/api/generated/openAPI.enums.swagger.dart';

import 'content_card.dart';

class UseCaseGuide extends StatelessWidget {
  const UseCaseGuide({super.key});

  void _onUseCaseGuideTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('드로니 활용백서', style: system03),
          const Gap(12),
          FutureBuilder(
            // future: mockClient.articleHowToUseSummaryGet(
            //   articleTarget: ArticleHowToUseSummaryGetArticleTarget.all,
            // ),
            future: client.articleHowToUseSummaryGet(
              articleTarget: ArticleHowToUseSummaryGetArticleTarget.all,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.none ||
                  snapshot.data == null ||
                  !snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final data = snapshot.data!.body ?? [];

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: data
                    .map(
                      (d) => Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => _onUseCaseGuideTap(context),
                          child: ContentCard(
                            subTitle: '일반사용자',
                            article: d,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const Gap(20),
          GestureDetector(
            onTap: () => _onUseCaseGuideTap(context),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '더보러 가기',
                    style: system07.copyWith(color: AppColors.droniGray900),
                  ),
                  const SvgIcon(
                    icon: 'assets/image/icon/chevron_right.svg',
                    width: 20,
                    color: AppColors.droniGray900,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
