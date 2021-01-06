import 'services/api.dart';
import 'services/cache/sql_util.dart';
// 通过这个类来控制全局环境变量
class Env {
  static API apiClient;
  DbUtil dbClient;
}
