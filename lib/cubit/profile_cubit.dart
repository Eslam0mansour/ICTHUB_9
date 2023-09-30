import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/cubit/profile_state.dart';
import 'package:icthubx/data/models/user_data_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserData? userData;

  Future<void> getUserDataFromFireStore() async {
    try {
      emit(GetUserDataLoading());
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserData.fromDoc(userDoc);
      emit(GetUserDataDone());
    } catch (e) {
      emit(GetUserDataError(e.toString()));
    }
  }
}
