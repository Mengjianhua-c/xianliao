import 'package:xianliao/generated/json/base/json_convert_content.dart';
import 'package:xianliao/generated/json/base/json_field.dart';

class TopicsListEntity with JsonConvert<TopicsListEntity> {
	int code;
	String message;
	TopicsListData data;
}

class TopicsListData with JsonConvert<TopicsListData> {
	List<TopicsListDataTopic> topics;
	int total;
}

class TopicsListDataTopic with JsonConvert<TopicsListDataTopic> {
	int id;
	@JSONField(name: "user_id")
	int userId;
	String name;
	String title;
	int like;
	String ctime;
}
