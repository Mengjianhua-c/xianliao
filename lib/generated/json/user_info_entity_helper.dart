import 'package:xianliao/models/user/user_info_entity.dart';

userInfoEntityFromJson(UserInfoEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = new UserInfoData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> userInfoEntityToJson(UserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

userInfoDataFromJson(UserInfoData data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toInt();
	}
	if (json['progress'] != null) {
		data.progress = json['progress']?.toDouble();
	}
	if (json['roles'] != null) {
		data.roles = json['roles']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['phone'] != null) {
		data.phone = json['phone']?.toString();
	}
	if (json['max_size'] != null) {
		data.maxSize = json['max_size']?.toInt();
	}
	if (json['use_size'] != null) {
		data.useSize = json['use_size']?.toInt();
	}
	if (json['assess_key'] != null) {
		data.assessKey = json['assess_key']?.toString();
	}
	if (json['rule'] != null) {
		data.rule = json['rule']?.toString();
	}
	return data;
}

Map<String, dynamic> userInfoDataToJson(UserInfoData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['progress'] = entity.progress;
	data['roles'] = entity.roles;
	data['name'] = entity.name;
	data['username'] = entity.username;
	data['email'] = entity.email;
	data['phone'] = entity.phone;
	data['max_size'] = entity.maxSize;
	data['use_size'] = entity.useSize;
	data['assess_key'] = entity.assessKey;
	data['rule'] = entity.rule;
	return data;
}