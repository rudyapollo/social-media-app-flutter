import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          NxSliverAppBar(
            isFloating: true,
            bgColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Row(
              children: [
                NxAssetImage(
                  imgAsset: AssetValues.appIcon,
                  width: Dimens.thirtyTwo,
                  height: Dimens.thirtyTwo,
                ),
                Dimens.boxWidth8,
                Text(
                  StringValues.appName,
                  style: AppStyles.style18Bold,
                )
              ],
            ),
          ),
          GetBuilder<PostController>(
            builder: (logic) {
              if (logic.isLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              if (logic.postData == null || logic.postList.isEmpty) {
                return SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NxAssetImage(
                        imgAsset: AssetValues.error,
                        width: Dimens.hundred * 2,
                        height: Dimens.hundred * 2,
                      ),
                      Dimens.boxHeight8,
                      Text(
                        StringValues.noPosts,
                        style: AppStyles.style20Normal.copyWith(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Dimens.boxHeight16,
                      NxOutlinedButton(
                        width: Dimens.hundred * 1.4,
                        padding: Dimens.edgeInsets8,
                        label: StringValues.refresh,
                        onTap: () => logic.fetchAllPosts(),
                      )
                    ],
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    var post = logic.postList.elementAt(index);
                    return PostWidget(post: post);
                  },
                  childCount: logic.postList.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
