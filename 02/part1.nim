import std/tables, strutils, math
import std/nre

type Round = Table[string, int]
type Game = seq[Round]
type Games = Table[int, Game]

# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
proc parser(): Games =
  var games = initTable[int, Game]()

  for line in "input.txt".lines:
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

    games[gameId] = rounds

  return games

# The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

# In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration. However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; similarly, game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. If you add up the IDs of the games that would have been possible, you get 8.
proc isGameValid(game: Game, limits: Table[string, int]): bool =
  for round in game:
    for color, count in round:
      if count > limits[color]:
        return false
  return true

let games = parser()

var limits = initTable[string, int]()
limits["red"] = 12
limits["green"] = 13
limits["blue"] = 14

var validGameIds = newSeq[int]()

for id, game in games:
  if isGameValid(game, limits):
    validGameIds.add(id)

echo validGameIds.sum
