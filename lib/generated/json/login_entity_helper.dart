import 'package:xianliao/models/user/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = new LoginData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

loginDataFromJson(LoginData data, Map<String, dynamic> json) {
	if (json['assess_key'] != null) {
		data.assessKey = json['assess_key']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['roles'] != null) {
		data.roles = json['roles']?.toString();
	}
	return data;
}

Map<String, dynamic> loginDataToJson(LoginData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assess_key'] = entity.assessKey;
	data['username'] = entity.username;
	data['name'] = entity.name;
	data['roles'] = entity.roles;
	return data;
}