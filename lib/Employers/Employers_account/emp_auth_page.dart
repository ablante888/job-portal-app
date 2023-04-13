import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'emp_login.dart';
import 'emp_sign_up.dart';

class EmpAuthPage extends StatefulWidget {
  static const routName = '/EmpAuthPage';
  const EmpAuthPage({Key? key}) : super(key: key);

  @override
  State<EmpAuthPage> createState() => _EmpAuthPageState();
}

class _EmpAuthPageState extends State<EmpAuthPage> {
  bool isLogin = true;
  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? EmpLoginWidget(onclickedSignIn: toggle)
        : EmpsignUp(onclickedEmpSignUp: toggle);
  }
}
