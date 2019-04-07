abstract class BlocBase {
  /*
   * Should be used in every bloc class for disposing
   * stream controllers and or any other kind of disposables
   * For example check out login_bloc.dart
   */
  dispose();
}