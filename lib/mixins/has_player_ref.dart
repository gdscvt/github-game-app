import 'package:flame/components.dart';
import 'package:github_game/player.dart';

mixin HasPlayerRef on Component {
  Player? _playerRef;

  Player get player {
    if (_playerRef == null) {
      var c = parent;
      while (c != null) {
        if (c is HasPlayerRef) {
          _playerRef = c.player;
          return _playerRef!;
        } else if (c is Player) {
          _playerRef = c;
          return c;
        } else {
          c = c.parent;
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
