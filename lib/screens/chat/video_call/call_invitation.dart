import 'package:flutter/widgets.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../../utils/constants.dart';

void authenticate() {
 // emit(AppState.authenticated(user));

  try {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Constants.appId,
      appSign: Constants.appSign,
      userID:" user.id",
      userName:" user.name",
      plugins: [ZegoUIKitSignalingPlugin()],
      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(
          showFullScreen: true,
          fullScreenBackground: 'assets/images/logo.png',
          channelID: 'ZegoUIKit',
          channelName: 'Call Notifications',
          sound: 'call',
          icon: 'call',
        ),
        iOSNotificationConfig: ZegoCallIOSNotificationConfig(
          systemCallingIconName: 'CallKitIcon',
        ),
      ),
      requireConfig: (ZegoCallInvitationData data) {
        final config = (data.invitees.length > 1)
            ? ZegoCallInvitationType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
            : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoCallInvitationType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        config.topMenuBar.isVisible = true;
        config.topMenuBar.buttons
            .insert(0, ZegoCallMenuBarButtonName.minimizingButton);

        return config;
      },
    );
  } catch (error, stackTrace) {
    Text(error.toString());
  }
}