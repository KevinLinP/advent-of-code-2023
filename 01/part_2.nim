import std/nre, strutils, unicode

var total = 0

for line in "input.txt".lines:
  let firstNumber = find(line, re"(\d|one|two|three|four|five|six|seven|eight|nine)").get.captures[0]

  let firstDigit = case firstNumber
    of "one": "1"
    of "two": "2"
    of "three": "3"
    of "four": "4"
    of "five": "5"
    of "six": "6"
    of "seven": "7"
    of "eight": "8"
    of "nine": "9"
    else: firstNumber
  # echo firstDigit

  # lul
  let lastNumber = find(line.reversed, re"(\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)").get.captures[0]

  let lastDigit = case lastNumber
    of "eno": "1"
    of "owt": "2"
    of "eerht": "3"
    of "ruof": "4"
    of "evif": "5"
    of "xis": "6"
    of "neves": "7"
    of "thgie": "8"
    of "enin": "9"
    else: lastNumber
  # echo lastDigit

  let number = parseInt(firstDigit & lastDigit)
  echo number

  total += number

echo ""
echo total