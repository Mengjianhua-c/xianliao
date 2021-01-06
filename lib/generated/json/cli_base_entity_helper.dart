import 'package:xianliao/models/cli_base_entity.dart';

cliBaseEntityFromJson(CliBaseEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	return data;
}

Map<String, dynamic> cliBaseEntityToJson(CliBaseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	return data;
}