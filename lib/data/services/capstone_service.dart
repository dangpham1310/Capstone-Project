import 'package:dio/dio.dart';
import 'package:project/constants/app_data.dart';
import 'package:project/data/models/get_device_response.dart';
import 'package:project/data/models/get_telemetry_data_response.dart';
import 'package:project/data/models/get_topic_response.dart';
import 'package:project/data/models/publish_data_request.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
part 'capstone_service.g.dart';

@RestApi(baseUrl: AppData.baseUrl)
abstract class CapstoneService {
  factory CapstoneService(Dio dio, {String baseUrl}) = _CapstoneService;

  @POST('/publish')
  Future postPublishData({@Body() required PublishDataRequest body});

  @GET('/topics')
  Future<GetTopicResponse> getTopics();

  @GET('/devices')
  Future<GetDeviceResponse> getDevices();

  @GET('/data')
  Future<GetTelemetryDataResponse> getTelemetryData();
}
