// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/response_user.dart';
import 'package:social/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<OnGetUserAuthenticationEvent>(_onGetUserAuthentication);
    on<OnRegisterUserEvent>(_onRegisterUser);
    on<OnVerifyEmailEvent>(_onVerifyEmail);
    on<OnUpdatePictureCover>(_onUpdatePictureCover);
    on<OnUpdatePictureProfile>(_onUpdatePictureProfile);
    on<OnUpdateProfileEvent>(_onUpdateProfile);
    on<OnChangePasswordEvent>(_changePassword);
    on<OnToggleButtonProfile>(_toggleButtonProfile);
    on<OnChangeAccountToPrivacy>(_changeAccountPrivacy);
    on<OnLogOutUser>(_logOutAuth);
    on<OnAddNewFollowingEvent>(_addNewFollowing);
    on<OnAcceptFollowerRequestEvent>(_acceptFollowerRequest);
    on<OnDeletefollowingEvent>(_deleteFollowing);
    on<OnDeletefollowersEvent>(_deleteFollowers);
  }

  Future<void> _onGetUserAuthentication(
      OnGetUserAuthenticationEvent event, Emitter<UserState> emit) async {
    try {
      final data = await userRepositories.getUserById();
      emit(state.copyWith(user: data.user, postsUser: data.postsUser));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onRegisterUser(
      OnRegisterUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      await Future.delayed(const Duration(milliseconds: 550));

      final resp = await userRepositories.createdUser(
          event.fullname, event.username, event.email, event.password);

      if (resp.resp) {
        emit(SuccessUserState());
      } else {
        emit(FailureUserState(resp.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onVerifyEmail(
      OnVerifyEmailEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final resp = await userRepositories.verifyEmail(event.email, event.code);

      await Future.delayed(const Duration(milliseconds: 350));

      if (resp.resp) {
        emit(SuccessUserState());
      } else {
        emit(FailureUserState(resp.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onUpdatePictureCover(
      OnUpdatePictureCover event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      final data = await userRepositories.updatePictureCover(event.pathCover);

      await Future.delayed(const Duration(milliseconds: 450));
      if (data.resp) {
        final dataUser = await userRepositories.getUserById();

        emit(SuccessUserState());
        emit(
            state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onUpdatePictureProfile(
      OnUpdatePictureProfile event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data =
          await userRepositories.updatePictureProfile(event.pathProfile);

      await Future.delayed(const Duration(milliseconds: 450));

      if (data.resp) {
        final dataUser = await userRepositories.getUserById();

        emit(SuccessUserState());

        emit(
            state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      OnUpdateProfileEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingEditUserState());

      final data = await userRepositories.updateProfile(
          event.user, event.description, event.fullname, event.phone);

      if (data.resp) {
        final dataUser = await userRepositories.getUserById();

        emit(SuccessUserState());

        emit(
            state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _changePassword(
      OnChangePasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userRepositories.changePassword(
          event.currentPassword, event.newPassword);

      await Future.delayed(const Duration(milliseconds: 450));

      final dataUser = await userRepositories.getUserById();

      if (data.resp) {
        emit(SuccessUserState());

        emit(
            state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));
      } else {
        emit(FailureUserState(data.message));

        emit(
            state.copyWith(user: dataUser.user, postsUser: dataUser.postsUser));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _toggleButtonProfile(
      OnToggleButtonProfile event, Emitter<UserState> emit) async {
    emit(state.copyWith(isPhotos: event.isPhotos));
  }

  Future<void> _changeAccountPrivacy(
      OnChangeAccountToPrivacy event, Emitter<UserState> emit) async {
    try {
      emit(LoadingChangeAccount());

      final data = await userRepositories.changeAccountPrivacy();

      await Future.delayed(const Duration(milliseconds: 350));

      if (data.resp) {
        final data = await userRepositories.getUserById();

        emit(SuccessUserState());

        emit(state.copyWith(user: data.user, postsUser: data.postsUser));
      } else {
        FailureUserState(data.message);
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _logOutAuth(OnLogOutUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(postsUser: null, user: null));
  }

  Future<void> _addNewFollowing(
      OnAddNewFollowingEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingFollowingUser());

      final data = await userRepositories.addNewFollowing(event.uidFriend);

      if (data.resp) {
        final data = await userRepositories.getUserById();

        emit(SuccessFollowingUser());

        emit(state.copyWith(user: data.user, postsUser: data.postsUser));
      } else {
        FailureUserState(data.message);
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _acceptFollowerRequest(
      OnAcceptFollowerRequestEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userRepositories.acceptFollowerRequest(
          event.uidFriend, event.uidNotification);

      if (data.resp) {
        final data = await userRepositories.getUserById();

        emit(SuccessUserState());

        emit(state.copyWith(user: data.user, postsUser: data.postsUser));
      } else {
        FailureUserState(data.message);
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _deleteFollowing(
      OnDeletefollowingEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingFollowingUser());

      final data = await userRepositories.deleteFollowing(event.uidUser);

      if (data.resp) {
        final data = await userRepositories.getUserById();

        emit(SuccessFollowingUser());

        emit(state.copyWith(user: data.user, postsUser: data.postsUser));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _deleteFollowers(
      OnDeletefollowersEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingFollowersUser());

      final data = await userRepositories.deleteFollowers(event.uidUser);

      if (data.resp) {
        final data = await userRepositories.getUserById();

        emit(SuccessFollowersUser());

        emit(state.copyWith(user: data.user, postsUser: data.postsUser));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }
}
