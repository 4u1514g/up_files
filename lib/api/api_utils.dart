import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:up_files/api/models/user_model.dart';
import 'package:up_files/helper/ruler.dart';

part 'api_utils.g.dart';

@RestApi(baseUrl: Ruler.url)
abstract class APIUtils {
  factory APIUtils(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: 20000,
        connectTimeout: 20000,
        receiveDataWhenStatusError: true);
    return _APIUtils(dio, baseUrl: baseUrl);
  }

  @POST('sign-up.php')
  Future<String> signUp(
    @Field('phone') String tk,
    @Field('password') String mk,
    @Field('name') String name,
  );

  @POST('sign-in.php')
  Future<UserModel> signIn(
    @Field('phone') String tk,
    @Field('password') String mk,
  );

}
