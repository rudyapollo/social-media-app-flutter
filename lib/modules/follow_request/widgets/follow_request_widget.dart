import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/follow_request.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class FollowRequestWidget extends StatelessWidget {
  const FollowRequestWidget({
    Key? key,
    required this.followRequest,
    this.bottomMargin,
    this.onTap,
    this.bgColor,
    this.avatarSize,
    this.borderRadius,
    this.padding,
    required this.totalLength,
    required this.index,
  }) : super(key: key);

  final FollowRequest followRequest;
  final int totalLength;
  final int index;
  final double? bottomMargin;
  final VoidCallback? onTap;
  final double? avatarSize;
  final EdgeInsets? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find;
    return InkWell(
      onTap: onTap ??
          () => RouteManagement.goToUserProfileView(followRequest.from.id),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottomMargin ?? Dimens.zero),
            padding: padding ?? Dimens.edgeInsets8,
            constraints: BoxConstraints(
              maxWidth: Dimens.screenWidth,
            ),
            decoration: BoxDecoration(
              color: bgColor ?? Theme.of(Get.context!).dialogBackgroundColor,
              borderRadius: (index == 0 || index == totalLength - 1)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      topRight: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      bottomLeft: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                      bottomRight: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                    )
                  : const BorderRadius.all(Radius.zero),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: followRequest.from.id,
                        child: AvatarWidget(
                          avatar: followRequest.from.avatar,
                          size: avatarSize ?? Dimens.twentyFour,
                        ),
                      ),
                      Dimens.boxWidth8,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildUserUsername(),
                            _buildUserFullName(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (followRequest.from.id != profile.profileDetails!.user!.id)
                  _buildFollowAction(),
              ],
            ),
          ),
          if (index != totalLength - 1) Dimens.divider,
        ],
      ),
    );
  }

  Widget _buildUserUsername() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: followRequest.from.uname,
                style: AppStyles.style13Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (followRequest.from.isVerified) Dimens.boxWidth4,
          if (followRequest.from.isVerified)
            Icon(
              CupertinoIcons.checkmark_seal_fill,
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? Theme.of(Get.context!).textTheme.bodyText1?.color
                  : ColorValues.primaryColor,
              size: Dimens.fourteen,
            )
        ],
      );

  Widget _buildUserFullName() => RichText(
        text: TextSpan(
          text: '${followRequest.from.fname} ${followRequest.from.lname}',
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(Get.context!).textTheme.subtitle1!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildFollowAction() => Expanded(
        flex: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.boxWidth16,
            NxIconButton(
              bgColor: ColorValues.successColor,
              borderRadius: Dimens.four,
              padding: Dimens.edgeInsets4,
              width: Dimens.fourtyEight,
              icon: Icons.check_outlined,
              iconColor: ColorValues.whiteColor,
              onTap: () => FollowRequestController.find
                  .acceptFollowRequest(followRequest.id),
            ),
            Dimens.boxWidth8,
            NxIconButton(
              bgColor: ColorValues.errorColor,
              borderRadius: Dimens.four,
              padding: Dimens.edgeInsets4,
              width: Dimens.fourtyEight,
              icon: Icons.close,
              iconColor: ColorValues.whiteColor,
              onTap: () => FollowRequestController.find
                  .removeFollowRequest(followRequest.id),
            ),
          ],
        ),
      );
}
