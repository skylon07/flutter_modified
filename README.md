# Flutter Material Modified
A few small changes to give flutter a different flavor.


## Stateful Building
In flutter, a `StatefulWidget` is responsible for creating its associated `State`, then that `State` defines how the widget should `build()`.

```dart
class MyWidget extends StatefulWidget {
    const MyWidget({super.key});

    @override
    State createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
    // state props and function stuff

    Widget build(BuildContext context) {
        return MyFancyWidgetTree();
    }
}
```

This package delegates the `build()` definition as a duty of the `StatefulWidget` instead.

```dart
class MyWidget extends StatefulWidget<_MyWidgetState> {
    const MyWidget({super.key});

    @override
    State createState() => _MyWidgetState();
    
    @override
    Widget build(BuildContext context, _MyWidgetState state) {
        return MyFancyWidgetTree();
    }
}

class _MyWidgetState extends State<MyWidget> {
    // state props and function stuff
}
```

This change was included since the idea behind `Widget`s is to recursively compose other `Widget`s in a way that represents how the `Element` tree will be structured. Defining `build()` in the `StatefulWidget` instead of its `State` feels like it follows this recursion idea better.


## After-building
One small enhancement was added to the `State`s of `StatefulWidget`s that allows them to more conveniently run arbitrary code after the widget has rebuilt.

(This example just aims to show what it looks like to use `afterBuild()`; this is not meant to illustrate any specific use case.)

```dart
class _MyWidgetState extends State<MyWidget> {
    int animationStage = -1;

    void startMyAnimation() {
        setState(() {
            animationStage = 0;
        });

        afterBuild(_animateStage1)
    }

    void _animateStage1() {
        setState(() {
            animationStage = 1;
        })

        afterBuild(() {
            _makeSomeApiCalls();
            _animateStage2();
        })
    }

    void _animateStage2() {
        // ...
    }

    void _makeSomeApiCalls() {
        // ...
    }
}
```
