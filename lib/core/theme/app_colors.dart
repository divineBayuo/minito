// static colour palette consumed by AppTheme
// keeping colours here, makes it easy to reference
// them in widgets without BuildContext

import 'dart:ui';

abstract class AppColors {
  // primary brand
  static const primary = Color(0xFF1A73E8); // google blueish
  static const primaryDark = Color(0xFF4DA3FF); // lightened
  static const onPrimary = Color(0xFFFFFFFF);

  // secondary / accent
  static const secondary = Color(0xFF00897B);
  static const secondaryDark = Color(0xFF4DB6AC);

  // recording / live indicator
  static const recordingRed = Color(0xFFE53935);
  static const recordingPulse = Color(0xFFEF9A9A);

  // processing / pending
  static const processingAmber = Color(0xFFFFA000);

  // surfaces
  static const surfaceLight = Color(0xFFF8F9FA);
  static const surfaceDark = Color(0xFF1E1E2E);
  static const cardLight = Color(0xFFFFFFFF);
  static const cardDark = Color(0xFF2A2A3E);

  // text
  static const textPrimary = Color(0xFF1C1B1F);
  static const textSecondary = Color(0xFF49454F);
  static const textPrimaryDark = Color(0xFFE6E1E5);
  static const textSecondaryDark = Color(0xFFCAC4D0);

  // output type chips
  static const minutesColor = Color(0xFF1565C0);
  static const notesColor = Color(0xFF2E7D32);
  static const reportColor = Color(0xFF6A1B9A);
  static const actionItemsColor = Color(0xFFE65100);
}
