import 'package:flutter/material.dart';

/// This class is used to handle scroll controller
///
/// Example:
/// ```
/// class ChatCubit extends Cubit<ChatCubitState> {
///  ChatCubit() : super(ChatInitial());
///   final ScrollControllerHandler scrollControllerHandler =
///      ScrollControllerHandler(ScrollController());
///  void sendMessage() {
///   scrollControllerHandler.scrollToBottom();
/// }
/// ```
///
class ScrollControllerHandler {
  final ScrollController _scrollController;

  ScrollControllerHandler(ScrollController scrollController)
      : _scrollController = scrollController;

  ScrollController get scrollController => _scrollController;
  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  double get currentScrollPosition {
    return _scrollController.offset;
  }

  void scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  bool areChildrenOutOfRange() {
    return _scrollController.position.maxScrollExtent > 0;
  }

  bool isUserScrollToPosition(double position) {
    return _scrollController.offset >= position;
  }

  void removeListerner({void Function()? listener}) {
    _scrollController.removeListener(listener ?? () {});
  }

  void setActionWhenUserScrollAfterPosition({
    required double position,
    required Function() trueAction,
    void Function()? falseAction,
  }) {
    _scrollController.addListener(
      () {
        if (hasAtached()) {
          if (isUserScrollToPosition(position)) {
            trueAction();
          } else if (falseAction != null) {
            falseAction();
          }
        }
      },
    );
  }

  void setActionToListen({
    required Function() action,
    bool Function()? where,
    void Function()? onFalse,
  }) {
    _scrollController.addListener(
      () {
        if (hasAtached()) {
          if (where == null ? true : where()) {
            _scrollController.removeListener(action);
            action();
          } else if (onFalse == null ? false : true) {
            onFalse();
          }
        }
      },
    );
  }

  bool hasAtached() => scrollController.hasClients;
}
