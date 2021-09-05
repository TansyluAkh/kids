import 'package:bebkeler/infrastructure/mvvm/view_model.dart';
import 'package:flutter/widgets.dart';

abstract class View<Vm extends ViewModel> extends StatefulWidget {
  View({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final Vm viewModel;

  @protected
  Widget build(BuildContext context);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.init();
    widget.viewModel.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(View oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewModel != oldWidget.viewModel) {
      oldWidget.viewModel.removeListener(_handleChange);
      widget.viewModel.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_handleChange);
    widget.viewModel.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // Just trigger default rebuild mechanism because state (viewModel) is already updated
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}

class ViewBuilder<Vm extends ViewModel> extends View<Vm> {
  final Widget Function(BuildContext, Vm, Widget) builder;
  final Widget child;

  ViewBuilder({Key key, @required Vm viewModel, @required this.builder, this.child})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context) => builder(context, viewModel, child);
}
