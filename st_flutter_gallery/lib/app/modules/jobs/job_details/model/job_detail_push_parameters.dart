import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/start_job_page/model/write_job_info_model.dart';
import 'package:st/app/modules/jobs/underway_job/model/records.dart';

class JobDetailPushParameters {
  JobDetailPushParameters({
    required this.type,
    this.record,
    this.writeJobInfoModel,
  });
  JobActionType type;
  WriteJobInfoModel? writeJobInfoModel;
  Records? record;
}
