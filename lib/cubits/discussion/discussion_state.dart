import 'package:echo/model/discussions/discussions_model.dart';


abstract class DiscussionState {}

class DiscussionInitial extends DiscussionState {}

class GetAllDiscussionsLoadingState extends DiscussionState {}
class GetAllDiscussionsErrorState extends DiscussionState {
  String error;
  GetAllDiscussionsErrorState(this.error);
}
class GetAllDiscussionsSuccessState extends DiscussionState {
  DiscussionsModel model;
  GetAllDiscussionsSuccessState(this.model);
}


