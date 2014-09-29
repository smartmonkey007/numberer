import 'package:redstone/server.dart' as app;
import 'dart:math';
import 'dart:convert' as dConvert;

int gameNumber = 0;
List<Game> Games = new List<Game>();
Random rnd = new Random();
int CurrentNumber = 0;

void main() {
  gameNumber++;
  CurrentNumber = rnd.nextInt(10);
  app.setupConsoleLog();
  app.start();
  
  print("cheating for looking: " + CurrentNumber.toString());
}

@app.Route('/')
returnHome() {
  var returnS = '';
  Games.forEach((g) => returnS += 
    g.toString() + "\r\n"     
  );
  
  return returnS;
  
}

@app.Route('/:name')
returnPlayer(String name) { 
 var returnS = '';
  Games.where((p) => p.solver == name).forEach((g) => returnS += 
    g.toString() + "\r\n"     
  );
  
  return returnS;
  
}

@app.Route('/play/:name/:number')
playGame(String name, int number) {
  if (number == CurrentNumber) {
    Games.add(new Game()
      ..name = "Game: " + gameNumber.toString()
      ..solver = name
      ..number = number
    );
    gameNumber++;
    CurrentNumber = rnd.nextInt(10);
    
    if (Games.length > 1000) {
      Games = Games.skip(100); 
    }
    
    print("cheating for looking: " + CurrentNumber.toString());
    return "congtrats you won!";
  }
  else {
    return 'You lost, ohh well, maybe next time.';
  }
  
}



class Game
{
  String name;
  int number;
  String solver;
  
  @override 
  String toString()
  {
    return "$name    $number     $solver";
  }
  
  Map toMap()
  {
      var map = {
        'name': name,
        'number': number,
        'solver': solver
      };
    
      return map;
  }
}
