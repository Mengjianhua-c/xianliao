import 'package:xianliao/models/topic/topic_detail_entity.dart';

topicDetailEntityFromJson(TopicDetailEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = new TopicDetailData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> topicDetailEntityToJson(TopicDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

topicDetailDataFromJson(TopicDetailData data, Map<String, dynamic> json) {
	if (json['topic'] != null) {
		data.topic = new TopicDetailDataTopic().fromJson(json['topic']);
	}
	if (json['files'] != null) {
		data.files = new List<TopicDetailDataFile>();
		(json['files'] as List).forEach((v) {
			data.files.add(new TopicDetailDataFile().fromJson(v));
		});
	}
	if (json['tags'] != null) {
		data.tags = new List<TopicDetailDataTag>();
		(json['tags'] as List).forEach((v) {
			data.tags.add(new TopicDetailDataTag().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> topicDetailDataToJson(TopicDetailData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.topic != null) {
		data['topic'] = entity.topic.toJson();
	}
	if (entity.files != null) {
		data['files'] =  entity.files.map((v) => v.toJson()).toList();
	}
	if (entity.tags != null) {
		data['tags'] =  entity.tags.map((v) => v.toJson()).toList();
	}
	return data;
}

topicDetailDataTopicFromJson(TopicDetailDataTopic data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['like'] != null) {
		data.like = json['like']?.toInt();
	}
	if (json['ctime'] != null) {
		data.ctime = json['ctime']?.toString();
	}
	if (json['utime'] != null) {
		data.utime = json['utime'];
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toInt();
	}
	return data;
}

Map<String, dynamic> topicDetailDataTopicToJson(TopicDetailDataTopic entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['name'] = entity.name;
	data['like'] = entity.like;
	data['ctime'] = entity.ctime;
	data['utime'] = entity.utime;
	data['user_id'] = entity.userId;
	return data;
}

topicDetailDataFileFromJson(TopicDetailDataFile data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['filename'] != null) {
		data.filename = json['filename']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['is_img'] != null) {
		data.isImg = json['is_img']?.toInt();
	}
	return data;
}

Map<String, dynamic> topicDetailDataFileToJson(TopicDetailDataFile entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['filename'] = entity.filename;
	data['name'] = entity.name;
	data['is_img'] = entity.isImg;
	return data;
}

topicDetailDataTagFromJson(TopicDetailDataTag data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['tag_name'] != null) {
		data.tagName = json['tag_name']?.toString();
	}
	if (json['like'] != null) {
		data.like = json['like']?.toInt();
	}
	return data;
}

Map<String, dynamic> topicDetailDataTagToJson(TopicDetailDataTag entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['tag_name'] = entity.tagName;
	data['like'] = entity.like;
	return data;
}