import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/database/databaseBase.dart';
import 'package:delivery_app/database/phone_auth.dart';
import 'package:delivery_app/helper/otphandler.dart';
import 'package:delivery_app/helper/sharedprefrences.dart';
import 'package:delivery_app/models/Cart.dart';
import 'package:delivery_app/screens/checkout/bloc/checkout_bloc.dart';
import 'package:delivery_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:delivery_app/screens/history/bloc/history_bloc.dart';
import 'package:delivery_app/screens/user_details/bloc/details_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final databaseProvider = Provider<Database>(
    (ref) => DatabaseBase(uid: FirebaseAuth.instance.currentUser.uid));

final favoriteblocprovider =
    Provider((ref) => FavoriteBloc(database: ref.read(databaseProvider)));

final cartProvider = ChangeNotifierProvider<Cart>((ref) => Cart());

final checkoutblocProvider =
    Provider((ref) => CheckoutBloc(database: ref.read(databaseProvider)));

final sizeconfig = Provider((ref) => SizeConfig());

final localStorageProvider = Provider((ref) async =>
    LocalStorage(sharedPreferences: await SharedPreferences.getInstance()));

final historyProvider =
    Provider((ref) => HistoryBloc(database: ref.watch(databaseProvider)));

final detailsblocProvider =
    Provider((ref) => DetailsBloc(database: ref.read(databaseProvider)));

final otpsentprovider =
    ChangeNotifierProvider<ShowOtpScreen>((ref) => ShowOtpScreen());
final phoneauth = Provider<PhoneAuth>((ref) => PhoneAuth());
