library material;

import 'package:flutter/material.dart' as material;

export 'package:flutter/material.dart' hide StatefulWidget, State;


@material.optionalTypeArgs
abstract class StatefulWidget<StateType extends material.State> extends material.StatefulWidget {
    const StatefulWidget({material.Key? key}) : super(key: key);

    @material.protected
    material.Widget build(material.BuildContext context, StateType state);
}

@material.optionalTypeArgs
abstract class State<WidgetType extends StatefulWidget> extends material.State<WidgetType> {
    @override
    material.Widget build(material.BuildContext context) {
        return widget.build(context, this);
    }

    /// Calls a function after the current build phase is completed. 
    @material.protected
    void afterBuild(void Function() callAfterBuild) {
        material.WidgetsBinding.instance.addPostFrameCallback((duration) => callAfterBuild());
    }
}
