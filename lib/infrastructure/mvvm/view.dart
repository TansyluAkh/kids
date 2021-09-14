import 'package:bebkeler/ui/shared/colors.dart';

import 'view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class View<Vm extends ViewModel> extends StatefulWidget {
  View({
    Key key,
    @required this.viewModel,
    Widget Function(BuildContext) loadingWidgetBuilder,
    void Function(BuildContext) onNonBlockingLoading,
  }) : super(key: key) {
    this.loadingWidgetBuilder = loadingWidgetBuilder ?? buildLoadingWidget;
    this.onNonBlockingLoading = onNonBlockingLoading ?? loadingModal;
  }

  final Vm viewModel;
  Widget Function(BuildContext) loadingWidgetBuilder;
  void Function(BuildContext) onNonBlockingLoading;

  @protected
  Widget build(BuildContext context);

  @override
  _ViewState createState() => _ViewState();

  Widget buildLoadingWidget(BuildContext context) => Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.element,
        ),
      ));

  loadingModal(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.element,
          ),
        );
      });
}

class _ViewState extends State<View> {
  bool isWidgetWasShown = false;
  bool isWidgetInLoadingState = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.init();

    widget.viewModel.addListener(rebuild);

    isWidgetInLoadingState = widget.viewModel.isLoading;
    widget.viewModel.loadingStateNotifier.addListener(handleLoadingChange);
  }

  @override
  void didUpdateWidget(View oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewModel != oldWidget.viewModel) {
      oldWidget.viewModel.removeListener(rebuild);
      widget.viewModel.addListener(rebuild);
      oldWidget.viewModel.loadingStateNotifier.removeListener(handleLoadingChange);
      widget.viewModel.loadingStateNotifier.addListener(handleLoadingChange);
    }
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(rebuild);
    widget.viewModel.loadingStateNotifier.removeListener(handleLoadingChange);
    widget.viewModel.dispose();
    super.dispose();
  }

  void handleLoadingChange() {
    if (isWidgetWasShown) {
      if (isWidgetInLoadingState == true && widget.viewModel.isLoading == false) {
        Navigator.of(context).pop();
        isWidgetInLoadingState = false;
      } else if (isWidgetInLoadingState == false && widget.viewModel.isLoading == true) {
        widget.onNonBlockingLoading(context);
        isWidgetInLoadingState = true;
      }
    } else if (isWidgetInLoadingState != widget.viewModel.isLoading) {
      isWidgetInLoadingState = widget.viewModel.isLoading;
      rebuild();
    }
  }

  void rebuild() {
    setState(() {
      // Just trigger default rebuild mechanism because state (viewModel) is already updated
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isWidgetWasShown && isWidgetInLoadingState) {
      return widget.loadingWidgetBuilder(context);
    }
    isWidgetWasShown = true;
    return widget.build(context);
  }
}

class ViewBuilder<Vm extends ViewModel> extends View<Vm> {
  final Widget Function(BuildContext, Vm, Widget) builder;
  final Widget child;

  ViewBuilder({Key key, @required Vm viewModel, @required this.builder, this.child})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context) => builder(context, viewModel, child);
}
