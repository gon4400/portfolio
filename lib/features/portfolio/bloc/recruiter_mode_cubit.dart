import 'package:flutter_bloc/flutter_bloc.dart';

class RecruiterModeCubit extends Cubit<bool> {
  RecruiterModeCubit() : super(false);

  void toggle() => emit(!state);
}
