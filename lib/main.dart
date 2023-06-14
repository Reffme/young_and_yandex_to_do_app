import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'observers/logging_bloc_observer.dart';
import 'observers/logging_cubit_observer.dart';
import 'to_do_app.dart';

void main() {
  Bloc.observer = LoggingBlocObserver();
  Bloc.observer = LoggingCubitObserver();


  runApp( MyApp());
}

