import '../model/ModelGlobalData.dart';
import 'Define.dart';

class UtilCommon{
  static bool IsTeacher()
  {
    return GlobalData.LoginUser!.roles.contains(RoleUser.Teacher.toString().split('.')[1]);
  }

  static bool IsAdmin()
  {
    return GlobalData.LoginUser!.roles.contains(RoleUser.Administrator.toString().split('.')[1]);
  }
}