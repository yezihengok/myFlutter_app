class Values{
  var pageNum;
  var pageSize;
  var keyWord;

  Values(this.pageNum, this.pageSize, this.keyWord);

//  一个User.fromJson 构造函数, 用于从一个map构造出一个 User实例 map structure
//  一个toJson 方法, 将 User 实例转化为一个map.
  Values.fromJson(Map<String, dynamic> json)
      : pageNum = json['pageNum'],
        keyWord = json['keyWord'],
        pageSize = json['pageSize'];

  ///返回一个 map
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'pageNum': pageNum,
        'keyWord': keyWord,
        'pageSize': pageSize,
      };

  ///测试手写装换json 字符串
  String toJsons(){
    Map<String, dynamic> map=this.toJson();
    var sb = StringBuffer("{");
    map.forEach((k,v) => sb.write("\"$k\":\"$v\","));
    //末尾多了个“,” 截取一下:
    String str=sb.toString().substring(0,sb.toString().length-1);

    sb=new StringBuffer(str);
    sb.write("}");

    print("转换的json:\n${sb.toString()}");
    return sb.toString();
  }
}