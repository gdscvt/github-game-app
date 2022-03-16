import 'package:python_game/entities/entity_group.dart';
import 'package:python_game/entities/individuals/computer.dart';
import 'package:python_game/level.dart';

class ComputerGroup extends EntityGroup<Computer> {
  ComputerGroup(
      String id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : super(id, entityJsons) {
    entities.addAll(
        entityJsons.map((json) => Computer(Position(json["x"], json["y"]))));
  }
}
