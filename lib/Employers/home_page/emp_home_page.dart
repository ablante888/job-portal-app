import '../emp_profile/emp_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmpHomePage extends StatefulWidget {
  const EmpHomePage({Key? key}) : super(key: key);

  @override
  State<EmpHomePage> createState() => _EmpHomePageState();
}

class _EmpHomePageState extends State<EmpHomePage> {
  @override
  Widget build(BuildContext context) {
    return EmployerRegistrationForm();
  }
}
