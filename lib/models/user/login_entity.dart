import 'package:xianliao/generated/json/base/json_convert_content.dart';
import 'package:xianliao/generated/json/base/json_field.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	int code;
	String message;
	LoginData data;
}

class LoginData with JsonConvert<LoginData> {
	@JSONField(name: "assess_key")
	String assessKey;
	String username;
	String name;
	String roles;
}
