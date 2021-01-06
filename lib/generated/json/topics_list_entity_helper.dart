import 'package:xianliao/models/topic/topics_list_entity.dart';

topicsListEntityFromJson(TopicsListEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = new TopicsListData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> topicsListEntityToJson(TopicsListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

topicsListDataFromJson(TopicsListData data, Map<String, dynamic> json) {
	if (json['topics'] != null) {
		data.topics = new List<TopicsListDataTopic>();
		(json['topics'] as List).forEach((v) {
			data.topics.add(new TopicsListDataTopic().fromJson(v));
		});
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	return data;
}

Map<String, dynamic> topicsListDataToJson(TopicsListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.topics != null) {
		data['topics'] =  entity.topics.map((v) => v.toJson()).toList();
	}
	data['total'] = entity.total;
	return data;
}

topicsListDataTopicFromJson(TopicsListDataTopic data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['like'] != null) {
		data.like = json['like']?.toInt();
	}
	if (json['ctime'] != null) {
		data.ctime = json['ctime']?.toString();
	}
	return data;
}

Map<String, dynamic> topicsListDataTopicToJson(TopicsListDataTopic entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['user_id'] = entity.userId;
	data['name'] = entity.name;
	data['title'] = entity.title;
	data['like'] = entity.like;
	data['ctime'] = entity.ctime;
	return data;
}