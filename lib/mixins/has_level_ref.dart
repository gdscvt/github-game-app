import 'package:flame/components.dart';
import 'package:github_game/level.dart';

mixin HasLevelRef on Component {
  Level? _levelRef;

  Level get level {
    if (_levelRef == null) {
      var c = parent;
      while (c != null) {
        if (c is HasLevelRef) {
          _levelRef = c.level;
          return _levelRef!;
        } else if (c is Level) {
          _levelRef = c;
          return c;
        } else {
          c = c.parent;
        }
      }
      throw StateError('Cannot find reference level in the component tree');
    }
    return _levelRef!;
  }

  @override
  void onRemove() {
    super.onRemove();
    _levelRef = null;
  }
}
