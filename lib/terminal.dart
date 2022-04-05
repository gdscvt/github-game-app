class Terminal {
  var requiredData;
  var solution;
  late var files; // files contains the array of files from the dataJson
  var url; // url contains the url of the folder from the dataJson
  // var popup;
  var toPush = [];
  var currDir =
      []; // currDir contains the files of the current directory; will change when cd is used and stuff
  late String commitMsg;
  late String display;
  late bool completed;
  var tutorial;
  var game_win;
  var directoryPath;

  Terminal(dataJson) {
    // requiredData contains tha translated json file into json object
    // requiredData = jsonDecode(dataJson[0]);
    requiredData = dataJson[0];

    if (requiredData['solution'].length == 0) {
      tutorial = requiredData['tutorial'];
    }
    solution = requiredData['solution'];
    url = requiredData['url'];
    files = [];
    commitMsg = "";
    display = "";
    completed = false;
    // this.popup = dataJson[0].popup;
    // popup = new Popup(this.popup);
    // TODO get the rest of the fields
    // files = requiredData['files'];
    // TODO "repo" to push to
  }

  parse(c) {
    // computer.lineCount += 3;
    display += '\n' + c + '\n';
    var cmd = c.split(" ");
    print(cmd);
    // TODO: Add the winning condition check
    switch (cmd[1]) {
      case "git":
        git(c);
        break;
      case "cd":
        if (cmd.length > 3) {
          // computer.lineCount += 2;
          display +=
              "\nError using cd, only supply one [args], and it must be a folder";
        } else {
          cd(cmd[2]);
        }
        break;
      case "ls":
        ls(currDir);
        break;
      // case "h":
      //   this.h(...cmd);
      //   break;
      case "cat":
        if (cmd.length > 3) {
          // computer.lineCount += 2;
          display += "\nError using cat, only supply one [args]";
        } else {
          cat(cmd[2]);
        }
        break;
      case "exit":
        exit();
        break;
      default:

        // computer.lineCount += 3;
        display += "\nNo such cmd found! :<\n";
        break;
    }

    // computer.code = "> ";

    // Only goes here if this is a tutorial level

    // var tutorialPassed = true;
    //
    // // TODO needs more work for levels later, and different checks
    // // Checks if the current level is tutorial
    // if (this.tutorial != null) {
    //   print("Here??\n");
    //
    //   this.tutorial.forEach((file) => {
    //     print(file);
    //       var currFileName = Object.keys(file)[0];
    //     var containsCurrentFile = false;
    //     for (var i = 0; i < this.files.length; i++) {
    //       var currFileNameRepo = Object.keys(this.tutorial[i])[0];
    //       if (currFileName == currFileNameRepo) containsCurrentFile = true;
    //       if (!containsCurrentFile) tutorialPassed = false;
    //     }
    //
    //     // Edge case: No files contained
    //     if (this.files.length == 0) tutorialPassed = false;
    //   });
    //
    // if (tutorialPassed) {
    // // Switches popup msg when tutorial is passed
    // // computer.lineCount +=
    // //   1 + this.requiredData.tutorialCompleteMsg.split("\n").length;
    // // this.display += "\n" + this.requiredData.tutorialCompleteMsg;
    // // popup = new Popup(this.requiredData.tutorialCompleteMsg);
    // this.game_win = true;
    // // changeLvl = true;
    // }
    if (completed) {
      print("completed!");
      // computer.lineCount +=
      // 1 + this.requiredData.levelCompleteMsg.split("\n").length;
      display += requiredData['levelCompleteMsg'];
      // popup = new Popup(this.requiredData.levelCompleteMsg);
      // changeLvl = true;
      game_win = true;
    }
  }

  git(c) {
    var cmd = c.split(" ");
    print('git : $cmd');
    switch (cmd[2]) {
      case "clone":
        if (files.isNotEmpty) {
          display += "Already cloned :<\n";
          return;
        }

        if (cmd[3] != url) {
          // computer.lineCount += 2;
          display += "Wrong URL :<\n";
          return;
        }

        files = requiredData['filesRepo'];
        print(files);
        currDir = requiredData['filesRepo'];
        // computer.lineCount += 2;
        display += 'Files from given repo cloned! \n';
        break;

      default:
        // computer.lineCount += 2;
        display += "No such cmd found! :<\n";
        break;
    }
  }

  cd(folder) {
    if (folder == "..") {
      // checks to see if currently at base directory
      if (directoryPath.length == 1) {
        // computer.lineCount += 2;
        display += "You're already at the base directory\n";
        return;
      }

      // if cd refers to base dir, then set currDir to the files of base dir
      currDir = files;
      // computer.lineCount += 2;
      display += "Back to base directory!\n";
      return;
    }

    var newDir;
    currDir.forEach((curr) {
      var currFileName = curr.keys.first;
      if (currFileName == folder) {
        // does things to cd into new dir
        directoryPath = '/$folder/';
        newDir = curr[folder];
        // computer.lineCount += 2;
        display += 'Now at $directoryPath\n';
      }
    });
    if (newDir != null) currDir = newDir;
  }

  cat(file) {
    print(file);
    if (!file.includes(".")) {
      // computer.lineCount += 3;
      display += "\nUse cat on files, not directories!\n";
      return;
    }
    currDir.forEach((curr) {
      var currFileName = curr.keys.first;
      if (currFileName == file) {
        // computer.lineCount += curr[currFileName].split("\n").length;
        display += curr[currFileName];
      }
    });
  }

  ls(files) {
    print(files);
    files.forEach((file) {
      var currFileName = file.keys;
      // computer.lineCount += 2;
      display += '$currFileName\n';
    });
  }

  exit() {
    // computerToggle = false;
    display = "";
  }
}
