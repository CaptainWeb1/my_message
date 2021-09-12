
class ExceptionUtils {

  static void printCatchError({required dynamic error, required dynamic stackTrace}) {
    print("error : ${error.toString()} \n stacktrace : ${stackTrace.toString()}");
  }

}