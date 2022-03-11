import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/computer.dart';

class ComputerGroup extends EntityGroup<Computer> {
  ComputerGroup(List<dynamic> entityJsons, Map<String, dynamic> properties)
      : super(entityJsons, properties);
}
