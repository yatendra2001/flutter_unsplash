import 'package:equatable/equatable.dart';

class FailureModel extends Equatable {
  final String code;
  final String message;

  FailureModel({this.code = '', this.message = ''});

  @override
  List<Object> get props => [code, message];

  @override
  bool get stringify => true;
}
