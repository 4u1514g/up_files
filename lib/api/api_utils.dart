import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:up_files/api/models/file_model.dart';
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
  @FormUrlEncoded()
  Future<String> signUp(
    @Field('phone') String tk,
    @Field('password') String mk,
    @Field('name') String name,
  );

  @POST('sign-in.php')
  @FormUrlEncoded()
  Future<UserModel> signIn(
    @Field('phone') String tk,
    @Field('password') String mk,
  );

  @GET('get-file.php')
  Future<List<FileModel>> getFiles(
    @Query('phone') String tk,
    @Query('password') String mk,
  );

  @POST('update-information.php')
  @FormUrlEncoded()
  Future<UserModel> upadteInfor(
      @Field('phone') String tk,
      @Field('password') String mk,
      @Field('password_update') String cmk,
      @Field('name_update') String name,
 );
}
