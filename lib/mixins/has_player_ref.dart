import 'package:flame/components.dart';
import 'package:github_game/player.dart';
import 'package:github_game/level.dart';
import 'package:github_game/mixins/has_level_ref.dart';

mixin HasPlayerRef on Component {
  Player? _playerRef;

  Player get player {
    if (_playerRef == null) {
      if (this is HasLevelRef) {
        return (this as HasLevelRef).level.player;
      } else {
        var c = parent;
        while (c != null) {
          if (c is HasPlayerRef) {
            _playerRef = c.player;
            return _playerRef!;
          } else if (c is Level) {
            return c.player;
          } else if (c is Player) {
            _playerRef = c;
            return c;
          } else {
            c = c.parent;
          }
        }
      }
      throw StateError('Cannot find reference player in the component tree');
    }
    return _playerRef!;
  }

  @override
  void onRemove() {
    super.onRemove();
    _playerRef = null;
  }
}
