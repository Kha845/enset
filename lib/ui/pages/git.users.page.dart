import 'dart:ffi';

import 'package:enset/ui/pages/git.repositories.dart';
import 'package:enset/ui/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../bloc/users.bloc.dart';
import '../themes/themes.dart';

class GitUsersPage extends StatelessWidget {
  const GitUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //permet de controller les données saisie sur la zone de text
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UsersBloc,UsersState>(
            builder: (context,state) {
              if(state is SearchUsersStateSuccessState){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Users"),
                    Text("${state.currentPage}/${state.totalPages}")
                  ],
                );
              }else{
                return const Text("Users Page");
              }

            }
          ),
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor))),
                    )),
                    IconButton(
                        onPressed: () {
                          String kw = textEditingController.text;
                          context.read<UsersBloc>()
                              .add(SearchUsersEvent(keyword: kw,
                          page:0,pageSize: 20));
                        },
                        icon: const Icon(Icons.search)
                    )
                  ],
                )),
            BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
              if (state is SearchUsersLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchUsersErrorState) {
                return Column(
                  children: [
                    Text(
                      state.errorMessage,
                      style: CustomThemes.errorTextStyle,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          UsersBloc userBloc=
                          context.read<UsersBloc>();
                          userBloc.add(userBloc.currentEvent);
                    },
                        child: const Text('Retry'))
                  ],
                );
              } else if (state is SearchUsersStateSuccessState) {
                return Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: (){
                      context.read<UsersBloc>().add(NextPageEvent(
                          keyword: state.currentKeyword,
                          page: state.currentPage+1,
                          pageSize:state.pageSize));
                    },
                    child: ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>GitRepositories(user: state.users[index])));
                            },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   Row(
                                     children: [
                                       CircleAvatar(
                                         radius:40,
                                         backgroundImage: NetworkImage(state.users[index].avatarUrl),

                                       ),
                                       const SizedBox(width: 10,),
                                       Text(state.users[index].login,style: Theme.of(context).textTheme.headline6,),
                                     ],
                                   ) ,

                                    CircleAvatar(
                                      child: Text("${state.users[index].score}"),
                                    )
                              ]),
                            ),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 2,
                          );
                        },
                        itemCount: state.users.length),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ));
  }
}
