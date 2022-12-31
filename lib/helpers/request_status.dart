enum Status { failure, success, loading, waiting }

class RequestStatus {
  final Status status;
  final String? message;

  RequestStatus({required this.status,this.message});
}
