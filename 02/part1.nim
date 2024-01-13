import std/tables, strutils
import std/nre

type Round = Table[string, int]
type Game = seq[Round]
type Games = Table[string, Game]

# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
proc parser(): Games =
  var games = initTable[string, Game]()

  for line in "test-input.txt".lines:
    let gameCaptures = line.find(re"Game (\d+): (.*)").get.captures
    let gameId = gameCaptures[0].parseInt
    let roundStrings = gameCaptures[1].split("; ")
    var rounds = newSeq[Round]()

    for roundString in roundStrings:
      var round = initTable[string, int]()

      for colorCount in roundString.split(", "):
        let colorCountCaptures = colorCount.find(re"(\d+) (\w+)").get.captures
        let color: string = colorCountCaptures[1]
        let count: int = colorCountCaptures[0].parseInt
        round[color] = count

      rounds.add(round)

    echo "Game ID: ", gameId
    echo rounds

  return games

discard parser()


