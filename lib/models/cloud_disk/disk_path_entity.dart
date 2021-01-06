import 'package:xianliao/generated/json/base/json_convert_content.dart';
import 'package:xianliao/generated/json/base/json_field.dart';

class DiskPathEntity with JsonConvert<DiskPathEntity> {
	int code;
	String message;
	DiskPathData data;
}

class DiskPathData with JsonConvert<DiskPathData> {
	List<DiskPathDataPath> paths;
}

class DiskPathDataPath with JsonConvert<DiskPathDataPath> {
	int id;
	String name;
	@JSONField(name: "folder_path")
	String folderPath;
	@JSONField(name: "group_id")
	int groupId;
	@JSONField(name: "create_time")
	String createTime;
	String type;
	@JSONField(name: "file_size")
	int fileSize;
	@JSONField(name: "file_name")
	String fileName;
	@JSONField(name: "is_thumb")
	int isThumb;
	@JSONField(name: "is_share")
	int isShare;
}
