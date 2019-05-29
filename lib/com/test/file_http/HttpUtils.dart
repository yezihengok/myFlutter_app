import 'package:dio/dio.dart';
import 'package:myflutter_app/com/test/eventbus/UserInfo.dart';
import 'package:myflutter_app/com/test/file_http/Values.dart';


///dio是一个强大的Dart Http请求库(dio内部使用HttpClient)，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时等。
///详见 https://github.com/flutterchina/dio/blob/master/README-ZH.md
  /*get：
  Response response;/response=await dio.get("/test?id=12&name=wendu")
  对于GET请求我们可以将query参数通过对象来传递，上面的代码等同于：
  response=await dio.get("/test",queryParameters:{"id":12,"name":"wendu"})
  post:
  response=await dio.post("/test",data:{"id":12,"name":"wendu"})
  发起多个并发请求:
  response= await Future.wait([dio.post("/info"),dio.get("/token")]);
  下载文件:
  response=await dio.download("https://www.google.com/",_savePath);
  发送 FormData:
  FormData formData = new FormData.from({
    "name": "wendux",
    "age": 25,
  });
  response = await dio.post("/info", data: formData)

  如果发送的数据是FormData，则dio会将请求header的contentType设为“multipart/form-data”。
  通过FormData上传多个文件:
  FormData formData = new FormData.from({
    "name": "wendux",
    "age": 25,
    "file1": new UploadFileInfo(new File("./upload.txt"), "upload1.txt"),
    "file2": new UploadFileInfo(new File("./upload.txt"), "upload2.txt"),
    // 支持文件数组上传
    "files": [
      new UploadFileInfo(new File("./example/upload.txt"), "upload.txt"),
      new UploadFileInfo(new File("./example/upload.txt"), "upload.txt")
    ]
  });
  response = await dio.post("/info", data: formData)*/


//定义一个top-level变量，页面引入该文件后可以直接使用httpUtils
var httpUtils = new HttpUtils();

class HttpUtils {
  //私有构造函数
  HttpUtils._internal(Dio dio);
  //Tips：Dart中实现单例模式的标准做法就是使用static变量+工厂构造函数的方式，这样就可以保证new EventBus()始终返回都是同一个实例，
  //保存单例
  static HttpUtils _singleton = new HttpUtils._internal(dio=new Dio());
  //工厂构造函数
  factory HttpUtils()=> _singleton;

  static Dio dio;
  static const String BaseUrl = "http://www.wanandroid.com/";

   void getHttp(String url, Function callback) async {
    try {
      Response response = await dio.get(BaseUrl+url);
      print(response.toString());
      callback(response.toString());
    } catch (e) {
      print(e);
    }
  }

   void postHttp(String url,arg,Function callback) async {

     Values info=arg as Values;
    try {
      //这个接口实际需要用get才会正确返回数据，这里我演示post 用法。会返回一个错误的json
      Response  response=await dio.post(url,data:info.toJson());

     // Response response=await dio.get(url,queryParameters:info.toJson());
      print("接口返回:${response.toString()}");

      callback(response.toString());
    } catch (e) {
      print(e);
    }
  }


}