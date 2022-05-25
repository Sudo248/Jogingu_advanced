import 'package:flutter/material.dart';

import 'dependency.dart';

class BasePageRoute<T> extends MaterialPageRoute<T> {
  BasePageRoute({
    required Widget Function(BuildContext) builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    Dependency? dependency,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ){
    dependency?.dependencies();
  }
}

// class BasePageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T>{
//
//   final WidgetBuilder builder;
//
//   @override
//   final bool maintainState;
//
//   final Dependency? dependency;
//
//   BasePageRoute({
//     required this.builder,
//     RouteSettings? settings,
//     this.maintainState = true,
//     bool fullscreenDialog = false,
//     this.dependency,
//   }) : assert(builder != null),
//         assert(maintainState != null),
//         assert(fullscreenDialog != null),
//         super(settings: settings, fullscreenDialog: fullscreenDialog) {
//     assert(opaque);
//   }
//
//   @override
//   Widget buildContent(BuildContext context) {
//       dependency?.dependencies();
//       return builder(context);
//   }
//
//   @override
//   String get debugLabel => '${super.debugLabel}(${settings.name})';
//
// }
