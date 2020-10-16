class DirectionModel {
  static const START_POINT = "startPoint";
  static const DESTINATION = "destination";
  static const LOCATION_BENCHMARKS = "locationBenchMarks";
  
  String _startPoint;
  String _destination;
  String _locationBenchmarks;

  //  getter
  String get startPoint => _startPoint;
  String get destination => _destination;
  String get locationBenchmarks => _locationBenchmarks;

  DirectionModel.fromMap(Map data) {
    _startPoint = data[START_POINT];
    _destination = data[DESTINATION];
    _locationBenchmarks = data[LOCATION_BENCHMARKS];
  }

  Map toMap() => {
    START_POINT : _startPoint,
    DESTINATION : _destination,
    LOCATION_BENCHMARKS : _locationBenchmarks,
  };
}