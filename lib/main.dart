import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:young_and_yandex_to_do_app/observers/logging_bloc_observer.dart';
import 'package:young_and_yandex_to_do_app/observers/logging_cubit_observer.dart';
import 'package:young_and_yandex_to_do_app/to_do_app.dart';

void main() {
  Bloc.observer = LoggingBlocObserver();
  Bloc.observer = LoggingCubitObserver();


  runApp( MyApp());
}

