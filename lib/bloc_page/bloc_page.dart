import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_event.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_state.dart';

class BlocPage extends Bloc<BlocEvent,BlocState>{
  BlocPage():super(InitialState()){
     on((event,emit){
        if(event is LoginEvent){
          emit(LoginState());
        }else if(event is RegisterEvent){
          emit(RegisterState());
        }else if(event is HomeEvent){
          emit(HomeState());
        }else if(event is NewPostEvent){
          emit(NewPostState());
        }else if(event is PostListEvent){
          emit(PostListState());
        }
     });
  }

 
}