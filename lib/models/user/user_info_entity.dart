import 'package:xianliao/generated/json/base/json_convert_content.dart';
import 'package:xianliao/generated/json/base/json_field.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	int code;
	String message;
	UserInfoData data;
}

class UserInfoData with JsonConvert<UserInfoData> {
	int uid;
	double progress;
	String roles;
	String name;
	String username;
	String email;
	String phone;
	@JSONField(name: "max_size")
	int maxSize;
	@JSONField(name: "use_size")
	int useSize;
	@JSONField(name: "assess_key")
	String assessKey;
	String rule;
}
