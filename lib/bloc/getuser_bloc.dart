import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:random_user_project/user_model.dart';

part 'getuser_event.dart';
part 'getuser_state.dart';

class GetuserBloc extends Bloc<GetuserEvent, GetUserState> {
  GetuserBloc() : super(GetuserInitial()) {
    List<Results> listUserModel = [];
    on<GetuserEvent>((event, emit) async {
      emit(GetuserLoading());
      try {
        Response response = await Dio().get('https://randomuser.me/api/');
        final List<dynamic> listOfJson = response.data;
        listUserModel =
            listOfJson.map<Results>((e) => Results.fromJson(e)).toList();

        emit(GetuserLoaded(listUserModel));
      } catch (e) {
        emit(GetuserError(e.toString()));
      }
    });
  }
}
