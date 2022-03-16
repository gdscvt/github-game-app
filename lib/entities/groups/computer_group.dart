import 'package:python_game/entities/entity_group.dart';
import 'package:python_game/entities/individuals/computer.dart';

class ComputerGroup extends EntityGroup<Computer> {
  ComputerGroup(
      String id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : super(id, entityJsons, properties);
}
