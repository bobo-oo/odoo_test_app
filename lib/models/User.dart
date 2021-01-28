import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:test_app/constants.dart';
// import 'package:test_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:test_app/main.dart';


class User with ChangeNotifier {
  int id;
  String name;
  String email;

  User({this.id, this.name, this.email});
  Future createUser (String userName, String userEmail, String userPassword) async {
    try {
      // Authenticate to server with db name and credentials
      var response = await login(kUsername, kPassword);
      var partnerId;
      var data;
      if (response['status'] == 1) {
        partnerId = await client.callKw({
          'model': 'res.users',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'domain': [
              ['login', '=', userName]
            ],
            'fields': ['id', 'name'],
          },
        });
        if(partnerId.length < 1) {
          partnerId = await client.callKw({
            'model': 'res.users',
            'method': 'create',
            'args': [
              {
                'name': userName, 'login': userEmail, 'password': userPassword,
              },
            ],
            'kwargs': {},
          });
          data = {'status':1,'data': partnerId,'message':'Registration completed successfully.'};
        }
        else {
          data = {'status':0,'data': partnerId,'message':'This email address is already registered.'};
        }
      }
      return data;

    } on OdooException catch (e) {
      // Cleanup on odoo exception
      var data = {'status':0,'message':e.message};
      print(e.message);
      print("log out");
      return data;
    }
  }
  Future fotgetPassword () async {
    try {
      // Authenticate to server with db name and credentials
      var response = await login('api@api.com', '123123123');
      var res = await client.callRPC('/web/session/get_lang_list', 'call', {});
      // var session = await client.;
      print(res);
      // print('\nInstalled modules: \n' + res.toString());
      // var response1 = await client.callRPC("/web/reset_password", "reset_password", {});
      var partnerId;
      var data;
      if (response['status'] == 1) {
        partnerId = await client.callKw({
          'model': 'res.users',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'domain': [
              ['login', '=', email]
            ],
            'fields': ['id', 'name'],
          },
        });
        print(partnerId);
        if(partnerId.length < 1) {
          data = {'status':0,'data': partnerId,'message':'This email address is already registered.'};
        }
        else {
          data = {'status':1,'data': partnerId,'message':'Registration completed successfully.'};
        }
      }
      return data;

    } on OdooException catch (e) {
      // Cleanup on odoo exception
      var data = {'status':0,'message':e.message};
      print(e);
      print("log out");
      return data;
    }

  }
  Future login(String username, String password) async {
    try {
      // Authenticate to server with db name and credentials
      var user = OdooClient(baseUrl);
      var clientSession = await client.authenticate(database, kUsername, kPassword);
      var session = await user.authenticate(database, username, password);
      print(session);
      print('Authenticated');
      var data = {'status':1,'data':session};
      // var userInfo = await client.callKw({
      //   'model': 'res.users',
      //   'method': 'search_read',
      //   'args': [],
      //   'kwargs': {
      //     'domain': [
      //       ['id', '=', session.id]
      //     ],
      //     'fields': ['id', 'name', 'login', 'partner_id'],
      //   },
      // });
      id = session.partnerId;
      name = session.userName;
      email = session.userLogin;

      // print(userInfo);
      return data;
      // return LoginUser.fromJson(session.toJson());

    } on OdooException catch (e) {
      // Cleanup on odoo exception
      var data = {'status':0,'data':e.message};
      print(e.message);
      print("log out");
      return data;
    }
  }
}
class LoginUser {
  final String id;
  final int userId;
  final String name;
  final String username;
  final int companyId;

  LoginUser({this.id, this.userId, this.name, this.username, this.companyId});

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      userId: json['userId'] as int,
      id: json['id'] as String,
      name: json['userName'] as String,
      username: json['userLogin'] as String,
      companyId: json['companyId'] as int,
    );
  }
}

