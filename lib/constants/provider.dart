import 'package:delivery_app/constants/size_config.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/database/databaseBase.dart';
import 'package:delivery_app/models/Cart.dart';
import 'package:delivery_app/screens/checkout/bloc/checkout_bloc.dart';
import 'package:delivery_app/screens/history/bloc/history_bloc.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<Database>(
    (ref) => DatabaseBase(uid: "ixMHMJGGWgNPEjvu6YZ0oo9ehst1"));

final cartProvider = ChangeNotifierProvider<Cart>((ref) => Cart());

final checkoutblocProvider =
    Provider((ref) => CheckoutBloc(database: ref.read(databaseProvider)));

final sizeconfig = Provider((ref) => SizeConfig());

final historyProvider =
    Provider((ref) => HistoryBloc(database: ref.watch(databaseProvider)));