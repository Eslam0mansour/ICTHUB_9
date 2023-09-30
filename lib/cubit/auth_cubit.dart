import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String email,
    required String pass,
  }) async {
    try {
      emit(LoginLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass)
          .then(
        (value) {
          if (value.user != null) {
            emit(LoginSuccess());
          }
        },
      );
    } on FirebaseException catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> signup({
    required String email,
    required String pass,
    required String name,
    required String phone,
  }) async {
    try {
      emit(SignupLoading());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then(
        (value) {
          if (value.user != null) {
            saveUserData(
              email,
              pass,
              name,
              phone,
              value.user!.uid,
            ).then((value) {
              if (value) {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomeLayout(),
                //   ),
                //       (route) => false,
                // );
                emit(SignupSuccess());
              }
            });
          }
        },
      );
    } catch (e) {
      emit(SignupError(e.toString()));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       e.toString(),
      //     ),
      //   ),
      // );
    }
  }

  Future<bool> saveUserData(
    String email,
    String pass,
    String name,
    String phone,
    String uid,
  ) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userName': name,
        'userEmail': email,
        'userPass': pass,
        'userPhone': phone,
        'uid': uid,
        'image': '',
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
