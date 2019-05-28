class LoginEntity {
  String headerValue;
  String headerKey;
  LoginUser user;

  LoginEntity({this.headerValue, this.headerKey, this.user});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    headerValue = json['headerValue'];
    headerKey = json['headerKey'];
    user = json['user'] != null ? new LoginUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headerValue'] = this.headerValue;
    data['headerKey'] = this.headerKey;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class LoginUser {
  String schema;
  String teamName;
  int adminType;
  List<Null> roles;
  String mobile;
  String logo;
  String userName;
  String job;
  int userId;
  String base;
  String qrcodePosition;

  LoginUser(
      {this.schema,
      this.teamName,
      this.adminType,
      this.roles,
      this.mobile,
      this.logo,
      this.userName,
      this.job,
      this.userId,
      this.base,
      this.qrcodePosition});

  LoginUser.fromJson(Map<String, dynamic> json) {
    schema = json['schema'];
    teamName = json['teamName'];
    adminType = json['adminType'];
    if (json['roles'] != null) {
      roles = new List<Null>();
    }
    mobile = json['mobile'];
    logo = json['logo'];
    userName = json['userName'];
    job = json['job'];
    userId = json['userId'];
    base = json['base'];
    qrcodePosition = json['qrcodePosition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schema'] = this.schema;
    data['teamName'] = this.teamName;
    data['adminType'] = this.adminType;
    if (this.roles != null) {
      data['roles'] = [];
    }
    data['mobile'] = this.mobile;
    data['logo'] = this.logo;
    data['userName'] = this.userName;
    data['job'] = this.job;
    data['userId'] = this.userId;
    data['base'] = this.base;
    data['qrcodePosition'] = this.qrcodePosition;
    return data;
  }
}
