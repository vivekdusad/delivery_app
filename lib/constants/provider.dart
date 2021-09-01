import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/database/databaseBase.dart';
import 'package:delivery_app/database/phone_auth.dart';
import 'package:delivery_app/helper/current_user.dart';
import 'package:delivery_app/helper/otphandler.dart';
import 'package:delivery_app/helper/search_history.dart';
import 'package:delivery_app/helper/sharedprefrences.dart';
import 'package:delivery_app/models/Cart.dart';
import 'package:delivery_app/screens/checkout/bloc/checkout_bloc.dart';

import 'package:delivery_app/screens/history/bloc/history_bloc.dart';
import 'package:delivery_app/screens/login/bloc/login_bloc.dart';
import 'package:delivery_app/screens/order_details/bloc/orderdetails_bloc.dart';
import 'package:delivery_app/screens/results/bloc/results_bloc.dart';
import 'package:delivery_app/screens/search/bloc/search_bloc.dart';
import 'package:delivery_app/screens/user_details/bloc/details_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<Database>(
    (ref) => DatabaseBase(uid: FirebaseAuth.instance.currentUser.uid));

final cartProvider = ChangeNotifierProvider<Cart>((ref) => Cart());

final checkoutblocProvider =
    Provider((ref) => CheckoutBloc(database: ref.read(databaseProvider)));

final sizeconfig = Provider((ref) => SizeConfig());

final localStorageProvider = Provider<LocalStorage>((ref) => LocalStorage());

final historyProvider =
    Provider((ref) => HistoryBloc(database: ref.watch(databaseProvider)));

final detailsblocProvider =
    Provider((ref) => DetailsBloc(database: ref.read(databaseProvider)));

final otpsentprovider = Provider<ShowOtpScreen>((ref) => ShowOtpScreen());
final phoneauth = Provider<PhoneAuth>((ref) => PhoneAuth());

final searchblocprovider = Provider((ref) => SearchBloc());

final currentUserprovider =
    ChangeNotifierProvider((ref) => CurrentUserNotifer());

final loginblocprovider = Provider((ref) => LoginBloc());

final resultsblocProvider =
    Provider((ref) => ResultsBloc(ref.read(databaseProvider)));

final orderdetailblocprovider = Provider((ref) => OrderdetailsBloc());

final historyListProvider = ChangeNotifierProvider((ref) => SearchHistory());

