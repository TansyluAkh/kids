import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewModel extends ChangeNotifier {
  final loadingStateNotifier = ValueNotifier(false);

  bool get isLoading => loadingStateNotifier.value;
  void setLoading(bool value) {
    loadingStateNotifier.value = value;
  }

  void init() {}

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
  }
}

abstract class View<Vm extends ViewModel> extends StatefulWidget {
  View({
    Key? key,
    required this.viewModel,
    Widget Function(BuildContext)? loadingWidgetBuilder,
    void Function(BuildContext)? onNonBlockingLoading,
  }) : super(key: key) {
    this.loadingWidgetBuilder = loadingWidgetBuilder ?? buildLoadingWidget;
    this.onNonBlockingLoading = onNonBlockingLoading ?? loadingModal;
  }

  final Vm viewModel;
  Widget Function(BuildContext)? loadingWidgetBuilder;
  void Function(BuildContext)? onNonBlockingLoading;

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
        widget.onNonBlockingLoading?.call(context);
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
    if (!isWidgetWasShown && isWidgetInLoadingState && widget.loadingWidgetBuilder != null) {
      return widget.loadingWidgetBuilder!.call(context);
    }
    isWidgetWasShown = true;
    return widget.build(context);
  }
}

class ViewBuilder<Vm extends ViewModel> extends View<Vm> {
  final Widget Function(BuildContext, Vm, Widget?) builder;
  final Widget? child;

  ViewBuilder({Key? key, required Vm viewModel, required this.builder, this.child})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context) => builder(context, viewModel, child);
}

mixin SingleTickerProviderViewModelMixin on ViewModel implements TickerProvider {
  Ticker? _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(() {
      if (_ticker == null) return true;
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary(
            '$runtimeType is a SingleTickerProviderWidgetModelMixin but multiple tickers were created.',
          ),
          ErrorDescription(
            'A SingleTickerProviderWidgetModelMixin can only be used as a TickerProvider once.',
          ),
          ErrorHint(
            'If a WidgetModel is used for multiple AnimationController objects, or if it is passed to other '
            'objects and those objects might use it more than one time in total, then instead of '
            'mixing in a SingleTickerProviderWidgetModelMixin, implement your own TickerProviderWidgetModelMixin.',
          ),
        ],
      );
    }());
    _ticker = Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    return _ticker!;
  }

  @override
  void dispose() {
    assert(() {
      if (_ticker == null || !_ticker!.isActive) return true;
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary(
            '$this was disposed with an active Ticker.',
          ),
          ErrorDescription(
            '$runtimeType created a Ticker via its SingleTickerProviderWidgetModelMixin, but at the time '
            'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
            'be disposed before calling super.dispose().',
          ),
          ErrorHint(
            'Tickers used by AnimationControllers '
            'should be disposed by calling dispose() on the AnimationController itself. '
            'Otherwise, the ticker will leak.',
          ),
          _ticker!.describeForError('The offending ticker was'),
        ],
      );
    }());
    super.dispose();
  }
}

mixin TickerProviderViewModelMixin on ViewModel implements TickerProvider {
  final _tickers = <Ticker>{};

  @override
  Ticker createTicker(TickerCallback onTick) {
    final result = _WidgetTicker(onTick, this, debugLabel: 'created by $this');
    _tickers.add(result);
    return result;
  }

  void _removeTicker(_WidgetTicker ticker) {
    assert(_tickers.contains(ticker));
    _tickers.remove(ticker);
  }

  @override
  void dispose() {
    assert(() {
      for (final ticker in _tickers) {
        if (ticker.isActive) {
          throw FlutterError.fromParts(
            <DiagnosticsNode>[
              ErrorSummary(
                '$this was disposed with an active Ticker.',
              ),
              ErrorDescription(
                '$runtimeType created a Ticker via its TickerProviderWidgetModelMixin, but at the time '
                'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
                'be disposed before calling super.dispose().',
              ),
              ErrorHint(
                'Tickers used by AnimationControllers '
                'should be disposed by calling dispose() on the AnimationController itself. '
                'Otherwise, the ticker will leak.',
              ),
              ticker.describeForError('The offending ticker was'),
            ],
          );
        }
      }
      return true;
    }());

    super.dispose();
  }
}

class _WidgetTicker extends Ticker {
  _WidgetTicker(
    TickerCallback onTick,
    this._creator, {
    String? debugLabel,
  }) : super(
          onTick,
          debugLabel: debugLabel,
        );

  final TickerProviderViewModelMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
