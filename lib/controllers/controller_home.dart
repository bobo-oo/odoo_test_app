// import 'dart:io';
// import 'package:odoo_rpc/odoo_rpc.dart';
//
//
//
// // sessionChanged(OdooSession sessionId) async {
// //   print('We got new session ID: ' + sessionId.id);
// //   print('Session Change');
// //   // write to persistent storage
// // }
// login() async {
//   const baseUrl = 'https://dp-shop.odoo.com';
//   final client = OdooClient(baseUrl);
//   // Subscribe to session changes to store most recent one
//   // var subscription = client.sessionStream.listen(sessionChanged);
//   try {
//     // Authenticate to server with db name and credentials
//     var session = await client.authenticate('dp-shop', "bobo.oo@digipowermm.com", "Test123!");
//     print(session);
//     print('Authenticated');
//     return session;
//   } on OdooException catch (e) {
//     // Cleanup on odoo exception
//     print(e);
//     print("log out");
//     // subscription.cancel();
//     client.close();
//     exit(-1);
//   }
// }
// getItem() async {
//   final client = OdooClient(baseUrl);
//   var res = await client.callKw({
//       'model': 'res.users',
//       'method': 'search_read',
//       'args': [],
//       'kwargs': {
//         'context': {'bin_size': true},
//         'domain': [
//         ],
//         // 'fields': ['id', 'name', '__last_update', 'image_128'],
//         'fields': ['id', 'name'],
//       },
//     });
//   print('\n info: \n' + res.toString()) as List<dynamic>;
//   return res;
// }