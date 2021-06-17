
import 'dart:html';

/*abstract class DataModel {}

class ContentData<T> implements DataModel {
  ContentData({required this.data});

  final T data;
}

class ErrorData implements DataModel {
  ErrorData({required this.message});

  final String message;
}

class LoadingData implements DataModel {
  const LoadingData();
}*/



la data peut etre

    un content data -> un user ou un null
    un error data
    un loading data

    Pour ça je dois donner en type un type AuthData qui puisse etre les 4 types précédents