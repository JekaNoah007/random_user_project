import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:random_user_project/user_model.dart';

part 'getuser_event.dart';
part 'getuser_state.dart';

class GetuserBloc extends Bloc<GetuserEvent, GetUserState> {
  GetuserBloc() : super(GetuserInitial()) {
    on<GetuserEvent>((event, emit) async {
      emit(GetuserLoading());
      try {
        Response response = await Dio().get('https://randomuser.me/api/');
        UserModal dataModel = UserModal.fromJson(response.data);

        emit(GetuserLoaded(dataModel));
      } catch (e) {
        emit(GetuserError(e.toString()));
      }
    });
  }
}
