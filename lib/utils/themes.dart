part of 'utils.dart';

mixin color {
  static final Color background = Vx.hexToColor('#FAFAFAC');
  static final Color semanticBlack = Vx.hexToColor('#383E43');
  static final Color primary = Vx.hexToColor('#75C2FE');
  static final Color secondary = Vx.hexToColor('#7874DF');
  static final Color accent = Vx.hexToColor('#FDCB6E');
}

mixin textStyle {
  static final TextStyle blackStyle1 = GoogleFonts.poppins(
    color: color.semanticBlack,
    fontWeight: FontWeight.w500,
  );
}
