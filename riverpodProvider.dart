import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omspos/screen/booking/state/booking_state.dart';
import 'package:omspos/screen/home/state/home_state.dart';
import 'package:omspos/screen/index/state/index_state.dart';
import 'package:omspos/screen/login/state/login_state.dart';
import 'package:omspos/screen/map/state/map_state.dart';
import 'package:omspos/screen/profile/state/profile_state.dart';
import 'package:omspos/screen/properties/state/properties_state.dart';
import 'package:omspos/screen/room/state/room_state.dart';
import 'package:omspos/services/language/localization_state.dart';
import 'package:omspos/themes/theme_state.dart';
import '../screen/splash/splash_state.dart';

// Global Riverpod providers
final splashProvider = ChangeNotifierProvider((ref) => SplashState());
final themeProvider = ChangeNotifierProvider((ref) => ThemeState());
final localizationProvider = ChangeNotifierProvider((ref) => LocalizationState());
final loginProvider = ChangeNotifierProvider((ref) => LoginState());
final homeProvider = ChangeNotifierProvider((ref) => HomeState());
final indexProvider = ChangeNotifierProvider((ref) => IndexState());
final profileProvider = ChangeNotifierProvider((ref) => ProfileState());
final propertiesProvider = ChangeNotifierProvider((ref) => PropertiesState());
final roomProvider = ChangeNotifierProvider((ref) => RoomState());
final bookingProvider = ChangeNotifierProvider((ref) => BookingState());
final mapProvider = ChangeNotifierProvider((ref) => MapState());
