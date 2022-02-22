import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/laser.dart';
import 'package:github_game/level.dart';

class LaserGroup extends EntityGroup<Laser> {
  @override
  void loadEntities() {
    entities.add(Laser(Position(5, 0)));
    entities.add(Laser(Position(6, 0)));
    entities.add(Laser(Position(7, 0)));
    entities.add(Laser(Position(8, 0)));
    entities.add(Laser(Position(5, 1)));
    entities.add(Laser(Position(6, 1)));
    entities.add(Laser(Position(7, 1)));
    entities.add(Laser(Position(8, 1)));
  }
}
