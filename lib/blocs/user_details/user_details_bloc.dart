import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  Future<void> _onFetchUserDetails(
    FetchUserDetails event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(UserDetailsLoading());
    try {
      final userDetails = await CloudFirestoreMethods().getNameAndAddress();
      emit(UserDetailsLoaded(userDetails));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }
}
