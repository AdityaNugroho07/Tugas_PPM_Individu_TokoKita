import 'package:tokokita/HELPERS/user_info.dart';

class LogoutBloc{
    static Future logout() async {
      await UserInfo().logout();
    }
  }
