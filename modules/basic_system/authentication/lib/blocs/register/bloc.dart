// import 'package:authentication/authentication.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:utils/algorithm.dart';
//
// import 'event.dart';
// import 'state.dart';
//
// /// create by 张风捷特烈 on 2021/1/17
// /// contact me by email 1981462002@qq.com
// /// 说明:
//
// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final AuthRepository repository;
//
//   RegisterBloc({required this.repository}) : super(RegisterNone()){
//     on<RegisterEvent>(_onRegisterEvent);
//   }
//
//   void _onRegisterEvent(RegisterEvent event,Emitter<RegisterState> emit) async {
//     if (event is DoRegister) {
//       emit(RegisterLoading());
//       TaskResult<bool> result =
//           await repository.register(email: event.email, code: event.code);
//
//       if(result.data == null){
//     emit(const RegisterError('注册失败'));
//       }else{
//         if (result.data!=null&&result.data!) {
//           // 注册成功
//           emit( RegisterSuccess(event.email));
//         }else{
//           emit( RegisterError(result.msg));
//         }
//       }
//     }
//   }
// }
