import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/laser.dart';
import 'package:github_game/level.dart';

/// This class represents a group of lasers that can be activated and
/// deactivated together.
class LaserGroup extends EntityGroup<Laser> {
  @override
  void loadEntities() {
    // ** DEBUGGING CODE **
    entities.add(Laser(Position(5, 0)));
    entities.add(Laser(Position(6, 0)));
    entities.add(Laser(Position(7, 0)));
    entities.add(Laser(Position(8, 0)));
    entities.add(Laser(Position(5, 1)));
    entities.add(Laser(Position(6, 1)));
    entities.add(Laser(Position(7, 1)));
    entities.add(Laser(Position(8, 1)));
  }

  /// Activate all lasers in the group.
  void activate() {
    for (Laser laser in entities) {
      laser.activate();
    }
  }

  /// Deactivate all lasers in the group.
  void deactivate() {
    for (Laser laser in entities) {
      laser.deactivate();
    }
  }
}
