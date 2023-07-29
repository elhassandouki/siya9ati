import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:syi9a/main.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final String apiKey = r'''
{
  "type": "service_account",
  "project_id": "syi9ati",
  "private_key_id": "806392b7e4e11993f0586df445de87dbdcb5ae99",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDUarZumaZwD820\nqknP7pvpxTZp/77fzkQgmnMIdQ6xSWWuOIKhOlfzqg58FEzWuUQErJJdcILJB3IK\nwP1bMNum2/Ebm35mV5dLXdShYdX0Y+gfaPdAm1bQL1WdZaXKx86kuZyTiV8sD8ux\nBK3gNHlhZSdJ8JCbwWCa0hGG0rwLJgFF5OMEwZbgYj6lPmH6vO4hxiT1EXOo5bbG\nzewvU7+y0vmHaUEAGfhQNcfmeKGHHhXGuBqXSbH+5csbwK0on3yOIa3mj4eOGLO6\n35/6N3+62SGDonK02vUDDXoYcO9dR5E+AjcmsaJMsZLigunderRJbTyOjq8chcUO\njvC5GwhxAgMBAAECggEABbbvvMK9Na1VKke9B98qWmQL+lbPKKf80Pg6wUbd6/LW\nrZTXXdVLHbLs5BVrOkkebXZDk0g2OoiM3sFxp3kFZcQrxMN+h2wSlcxazrMqPYKN\nEYBCS56KO7xURDFigBW3R1r3fYgf83hi0Vq3/0zGGbLOF2kFiO0vR0cAwfTsKmwR\nJDaoLUGY5n8RKjzbUJVqcNPbIxHV09OUmnCPqbPDOTVY/WRogn57A20orFO/GVpP\nA3kn5uuwaqG6H73O0uLFpMtEi7NGKHGVVeHK0C34muZJHVIWfoSeH1byzEbaeH1P\nO1QpTx044gUS69AJBwIo2teQl9co9eWdY71/4pa7gQKBgQDzv1zwpa0TTxZNhTUk\npa6saWggzg7Y6fIcen+tLIdE/zZqEOnrX/CuY/sx/U1+wBxh8EdEZVfZMIFHwORy\nMfvCJlJSMBNyvJwBbcSXPzAp+bkLlKlxjarqEfnNnBRAvDIndhrwz7dK7BDpMI9o\nQ2OBstpjPS0Q7rkYfvvM6skdQQKBgQDfGCyrlRukYvco7Vv517MD4q9wwI9MAfSA\nk8E+xeZH2cUT64pwKAfR4HFiBe3a+zfhWin/sS2jHAQHbyAHGZ45erdxNOLv/1o1\nQWq4AVp0gBx4zAqnlm2tL+aECLDcPmsHbSJ6FJ5SxMPhs/2DAuCa91viGRAL1Jn6\nGUq0bV2vMQKBgBFiOnynNDrGTy7kKzAb6OM++UAtsf1iYfQKAIUXQeZ31SenYSd6\nRi4Jz2Z3TEmX5e5ONqb4G1XQEchOR3yld/EWzpQx/ZEXRoELlRO8W/ECcGIVDiid\nE+1xrsEtOnyLb4BE+hLmnYnoYCRhZDjpZXVgjha5zDcC74yBse+hZwqBAoGAMfqe\nd0oOSUOKj3atdklmZ2ZvW1koQSTm+68eScvYDRyyVAYem4W8Sr53aDhf0wEYwbmL\nUycETFhIZsn0aOLKWaIuWoQ4mv+f2/Jt0A8tjo/s0PsVH/pJU9U5VTcFODIblCxU\n3vijh3NhVr0V/DW2z8C+quZme+ADJs5nuAgQRuECgYEA0BRuWP+cw2IFAT0ojLNN\nZpZzUCcx93cCA3pszHwwNUbjTVZkdgrQEPdFup5RpeQXy7RNFbEqr8zid4Sxshih\noxWDqQbPtbdiF/PsHY2hLLB+PQCslatT8LA/R/saKoPiWllEFNzJtTAs/Llljt/8\n0Xk/SYbu4sNK5ZgTspnlKwc=\n-----END PRIVATE KEY-----\n",
  "client_email": "syi9ati@syi9ati.iam.gserviceaccount.com",
  "client_id": "116331584408292264989",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/syi9ati%40syi9ati.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  final String sheetId = '1eWSxy20HKB3eAo7JHj2YPG-_4u7eJO0HUAt9wEGkShE';
  final String sheetName = '_data';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: const Color.fromARGB(255, 97, 69, 69),
                              offset: Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xfffbb448),
                              Color.fromARGB(255, 243, 165, 48),
                              Color(0xffe46b10)
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'الإسم',
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                            ),
                          ),
                          TextField(
                            textAlign: TextAlign.right,
                            controller: messageController,
                            decoration: InputDecoration(
                              labelText: 'الرسالة',
                            ),
                            maxLines: 4,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xfffbb448)),
                            ),
                            onPressed: () => executeFunction(context),
                            child: Text(
                              'إرسال',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  void executeFunction(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('عذرا، لا يمكنك الدخول ، تأكد من اتصالك بالأنترنت.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp())),
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Executing function...'),
                ],
              ),
            ),
          );
        },
      );

      final String name = nameController.text;
      final String email = emailController.text;
      final String message = messageController.text;

      final gsheets = GSheets(apiKey);
      final _data = await gsheets.spreadsheet(sheetId);
      var sheet = _data.worksheetByTitle(sheetName);

      final secondRow = {
        'Name': name,
        'Email': email,
        'Message': message,
      };
      //await sheet?.values.insertValue(name, column: 1, row: 1);
      await sheet?.values.map.appendRow(secondRow);
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context); // Hide the CircularProgressIndicator
      if (await sheet?.values.map.appendRow(secondRow) == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Function returned true. Exiting...'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp())),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
