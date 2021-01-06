import 'package:xianliao/models/cloud_disk/disk_path_entity.dart';

diskPathEntityFromJson(DiskPathEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = new DiskPathData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> diskPathEntityToJson(DiskPathEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

diskPathDataFromJson(DiskPathData data, Map<String, dynamic> json) {
	if (json['paths'] != null) {
		data.paths = new List<DiskPathDataPath>();
		(json['paths'] as List).forEach((v) {
			data.paths.add(new DiskPathDataPath().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> diskPathDataToJson(DiskPathData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.paths != null) {
		data['paths'] =  entity.paths.map((v) => v.toJson()).toList();
	}
	return data;
}

diskPathDataPathFromJson(DiskPathDataPath data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['folder_path'] != null) {
		data.folderPath = json['folder_path']?.toString();
	}
	if (json['group_id'] != null) {
		data.groupId = json['group_id']?.toInt();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['file_size'] != null) {
		data.fileSize = json['file_size']?.toInt();
	}
	if (json['file_name'] != null) {
		data.fileName = json['file_name']?.toString();
	}
	if (json['is_thumb'] != null) {
		data.isThumb = json['is_thumb']?.toInt();
	}
	if (json['is_share'] != null) {
		data.isShare = json['is_share']?.toInt();
	}
	return data;
}

Map<String, dynamic> diskPathDataPathToJson(DiskPathDataPath entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['folder_path'] = entity.folderPath;
	data['group_id'] = entity.groupId;
	data['create_time'] = entity.createTime;
	data['type'] = entity.type;
	data['file_size'] = entity.fileSize;
	data['file_name'] = entity.fileName;
	data['is_thumb'] = entity.isThumb;
	data['is_share'] = entity.isShare;
	return data;
}