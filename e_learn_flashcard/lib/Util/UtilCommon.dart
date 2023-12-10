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
  static String getInitials(String username) {
    List<String> words = username.split(" ");
    String initials = "";
    for (var word in words) {
      if (word.length > 0) {
        initials += word[0];
      }
    }
    return initials;
  }
}