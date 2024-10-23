abstract class Result<R> {
  const Result();
}

class Success<R> extends Result<R> {
  final R result;

  Success(this.result);
}

class Failure extends Result<Null> {
  final String message;

  Failure(this.message);
}

class Loading extends Result<Null> {
  const Loading();
}
