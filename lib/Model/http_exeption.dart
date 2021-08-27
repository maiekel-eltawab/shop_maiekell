class HttpExcepton implements Exception{
  final String message;

  HttpExcepton(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}