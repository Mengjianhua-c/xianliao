import 'package:xianliao/generated/json/base/json_convert_content.dart';
import 'package:xianliao/generated/json/base/json_field.dart';

class TopicDetailEntity with JsonConvert<TopicDetailEntity> {
	int code;
	String message;
	TopicDetailData data;
}

class TopicDetailData with JsonConvert<TopicDetailData> {
	TopicDetailDataTopic topic;
	List<TopicDetailDataFile> files;
	List<TopicDetailDataTag> tags;
}

class TopicDetailDataTopic with JsonConvert<TopicDetailDataTopic> {
	int id;
	String title;
	String content;
	String name;
	int like;
	String ctime;
	dynamic utime;
	@JSONField(name: "user_id")
	int userId;
}

class TopicDetailDataFile with JsonConvert<TopicDetailDataFile> {
	int id;
	String filename;
	String name;
	@JSONField(name: "is_img")
	int isImg;
}

class TopicDetailDataTag with JsonConvert<TopicDetailDataTag> {
	int id;
	@JSONField(name: "tag_name")
	String tagName;
	int like;
}
