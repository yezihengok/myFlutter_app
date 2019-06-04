class UserInfo{
  var username;
  var password;

  UserInfo(this.username, this.password);

  @override
  String toString() {
    return '{name: $username, pwd: $password}';
  }


}