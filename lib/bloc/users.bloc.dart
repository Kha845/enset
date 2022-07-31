//les actions
import 'package:bloc/bloc.dart';
import 'package:enset/repository/users.repository.dart';

import '../model/users.model.dart';

abstract class UsersEvent {}

class SearchUsersEvent extends UsersEvent {
  final String keyword;
  final int page;
  final int pageSize;
  SearchUsersEvent(
      {required this.keyword, required this.page, required this.pageSize});
}

//les states
abstract class UsersState {
  final  List<Users> users;
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final String currentKeyword;
  UsersState(
      {required this.users,
      required this.currentPage,
      required this.totalPages,
      required this.pageSize,
      required this.currentKeyword});
}

class SearchUsersStateSuccessState extends UsersState {
  SearchUsersStateSuccessState({
    required super.users,
    required super.currentPage,
    required super.totalPages,
    required super.pageSize,
    required super.currentKeyword});
}

class NextPageEvent extends SearchUsersEvent {
  NextPageEvent(
      {required super.keyword, required super.page, required super.pageSize});
}

class SearchUsersLoadingState extends UsersState {
  SearchUsersLoadingState({
    required super.users,
    required super.currentPage,
    required super.totalPages,
    required super.pageSize,
    required super.currentKeyword});
}

class SearchUsersErrorState extends UsersState {
  final String errorMessage;
  SearchUsersErrorState(
      {
        required super.users,
        required super.currentPage,
        required super.totalPages,
        required super.pageSize,
        required super.currentKeyword,
        required this.errorMessage});

}

class UsersInitialState extends UsersState {
  UsersInitialState():super(
    users: [],
    currentPage: 0,
    totalPages: 0,
    pageSize: 20,
    currentKeyword: ""
  );

}

//definir le bloc
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersReository usersReository = UsersReository();
  late UsersEvent currentEvent;
  UsersBloc() : super(UsersInitialState()) {
    on((SearchUsersEvent event, emit) async {
      currentEvent=event;
      emit(SearchUsersLoadingState(
        currentKeyword: state.currentKeyword,
        pageSize: state.pageSize,
        totalPages: state.totalPages,
        currentPage: state.currentPage,
        users: state.users
      ));
      try {
        ListUsers listUsers =
            await usersReository.searchUsers(event.keyword, event.pageSize, 10);
        int totalPages = (listUsers.totalCount / event.pageSize).floor();
        if (listUsers.totalCount % event.pageSize != 0) {
          totalPages = totalPages + 1;
        }
        emit(SearchUsersStateSuccessState(
            users: listUsers.items,
            currentPage: event.page,
            totalPages: totalPages,
            pageSize: event.pageSize,
            currentKeyword: event.keyword));
      } catch (e) {
        emit(SearchUsersErrorState(
            currentKeyword: state.currentKeyword,
            pageSize: state.pageSize,
            totalPages: state.totalPages,
            currentPage: state.currentPage,
            users: state.users,
            errorMessage: e.toString()));
      }
    });
    on((NextPageEvent event, emit) async {
      //emit(SearchUsersLoadingState());
      currentEvent=event;
      try {
        ListUsers listUsers =
            await usersReository.searchUsers(event.keyword, event.pageSize, 10);
        int totalPages = (listUsers.totalCount / event.pageSize).floor();

        if (listUsers.totalCount % event.pageSize != 0) {
          totalPages = totalPages + 1;
        }
        List<Users> currentList=[...state.users];
        currentList.addAll(listUsers.items);
        emit(SearchUsersStateSuccessState(
            users: currentList,
            currentPage: event.page,
            totalPages: totalPages,
            pageSize: event.pageSize,
            currentKeyword: event.keyword));
      } catch (e) {
        emit(SearchUsersErrorState(
            currentKeyword: state.currentKeyword,
            pageSize: state.pageSize,
            totalPages: state.totalPages,
            currentPage: state.currentPage,
            users: state.users,
            errorMessage: e.toString()));
      }
    });
  }
}
