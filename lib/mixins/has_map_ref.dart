import 'package:flame/components.dart';
import 'package:python_game/mixins/has_level_ref.dart';
import 'package:python_game/modules/level/map_module.dart';
import 'package:python_game/level.dart';

mixin HasMapRef on Component {
  MapModule? _mapRef;

  MapModule get mapModule {
    if (_mapRef == null) {
      if (this is HasLevelRef) {
        return (this as HasLevelRef).level.mapModule;
      } else {
        var c = parent;
        while (c != null) {
          if (c is HasMapRef) {
            _mapRef = c.mapModule;
            return _mapRef!;
          } else if (c is Level) {
            return c.mapModule;
          } else if (c is MapModule) {
            _mapRef = c;
            return c;
          } else {
            c = c.parent;
          }
        }
      }
      throw StateError(
          'Cannot find reference map module in the component tree');
    }
    return _mapRef!;
  }

  @override
  void onRemove() {
    super.onRemove();
    _mapRef = null;
  }
}
