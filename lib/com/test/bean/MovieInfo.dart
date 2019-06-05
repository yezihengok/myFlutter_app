class MovieInfo{
  var director; //导演
  var score;//评分
  var type;//类型
  var name;//名称
  var picUrl;//电影图片
  List<dynamic> actors;//演员头像
  MovieInfo(this.director, this.score, this.type, this.name, this.picUrl);

  @override
  String toString() {
    return 'MovieInfo{director: $director, score: $score, type: $type, name: $name, picUrl: $picUrl, actors: $actors}';
  }


}