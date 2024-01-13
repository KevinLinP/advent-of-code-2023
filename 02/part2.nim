import std/tables, strutils, math
import std/nre

type Round = Table[string, int]
type Game = seq[Round]
type Games = OrderedTable[int, Game]

# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
proc parser(): Games =
  var games = initOrderedTable[int, Game]()

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

# As you continue your walk, the Elf poses a second question: in each game you played, what is the fewest number of cubes of each color that could have been in the bag to make the game possible?

# Again consider the example games from earlier:

# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

#     In game 1, the game could have been played with as few as 4 red, 2 green, and 6 blue cubes. If any color had even one fewer cube, the game would have been impossible.
#     Game 2 could have been played with a minimum of 1 red, 3 green, and 4 blue cubes.
#     Game 3 must have been played with at least 20 red, 13 green, and 6 blue cubes.
#     Game 4 required at least 14 red, 3 green, and 15 blue cubes.
#     Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
proc fewestCubesOfEachColor(game: Game): Table[string, int] =
  var fewestCubes = {"red": 0, "green": 0, "blue": 0}.toTable
  for round in game:
    for color, count in round:
      if count > fewestCubes[color]:
        fewestCubes[color] = count

  return fewestCubes

# The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
proc powerOfCubes(cubes: Table[string, int]): int =
  var power = 1
  for color, count in cubes:
    power *= count
  return power

var games = parser()

# The power of the minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively. Adding up these five powers produces the sum 2286.

# For each game, find the minimum set of cubes that must have been present. What is the sum of the power of these sets?
var sum = 0

for gameId, game in games:
  let fewestCubes = fewestCubesOfEachColor(game)
  let power = powerOfCubes(fewestCubes)
  echo "Game ", gameId, ": ", fewestCubes, " => ", power
  sum += power

echo "Sum: ", sum
