import 'package:flutter/painting.dart';
import 'package:mijoo/core_ui/foundation/mj_colors.dart';

enum MjTone { lavender, peony, apricot, green, glacier, neutral }

extension MjToneColors on MjTone {
  Color get surface => switch (this) {
    MjTone.lavender => MjColors.heroLilac,
    MjTone.peony => MjColors.heroPink,
    MjTone.apricot => MjColors.apricotSoft,
    MjTone.green => MjColors.successSurface,
    MjTone.glacier => MjColors.glacier,
    MjTone.neutral => MjColors.field,
  };

  Color get foreground => switch (this) {
    MjTone.lavender => MjColors.primary,
    MjTone.peony => MjColors.peonyStrong,
    MjTone.apricot => MjColors.apricotDeep,
    MjTone.green => MjColors.success,
    MjTone.glacier => MjColors.glacierStrong,
    MjTone.neutral => MjColors.secondaryText,
  };
}
