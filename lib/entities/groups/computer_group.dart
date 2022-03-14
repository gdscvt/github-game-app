import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/computer.dart';
import 'dart:collection';
import 'package:git/git.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:path/path.dart' as p;

class ComputerGroup extends EntityGroup<Computer> with HasLevelRef {
  late final HashSet<String> _repoPaths;
  late final String _repoDirectoryPath;
  late final HashMap<String, GitDir> _repos;

  ComputerGroup(
      String id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : _repoPaths = HashSet(),
        _repos = HashMap(),
        super(id, entityJsons, properties) {
    if (properties?["repos"] != null) {
      List<dynamic> repos = properties!["repos"];

      for (Map<String, dynamic> repo in repos) {
        _repoPaths.add(repo["path"]);
      }
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _repoDirectoryPath = "assets/assets/levels/${level.id}/repos";

    for (String repoPath in _repoPaths) {
      await GitDir.fromExisting("${p.current}/$_repoDirectoryPath/$repoPath");
    }
  }
}
