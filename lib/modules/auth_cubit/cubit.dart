import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:code_app/modules/auth_cubit/states.dart';
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(AuthInitialState());

  // base url : https://student.valuxapps.com/api/register
  void register({required String email,required String name,
    required String phone,required String password}) async {
    emit(RegisterLoadingState());
    try{
      Response response = await http.post(
        // base url + method url ( endpoint )
          Uri.parse('https://student.valuxapps.com/api/register'),
          body: {
            'name' : name,
            'email' : email,
            'password' : password,
            'phone' : phone,
            'image' : "jdfjfj"
          },
      );
      if( response.statusCode == 200 )
        {
          var data = jsonDecode(response.body);
          if( data['status'] == true )
            {
              print("Response is : $data");
              emit(RegisterSuccessState());
            }
          else
            {
              print("Response is : $data");
              emit(FailedToRegisterState(message: data['message']));
            }
        }
    }catch(e){
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

}
