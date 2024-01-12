import std/nre, strutils

var count = 0

for line in "input.txt".lines:
  let firstDigit = find(line, re"(\d)").get.captures[0]
  let lastDigit = find(line, re"(\d)\D*$").get.captures[0]
  let number = parseInt(firstDigit & lastDigit)

  echo number
  count += number

echo ""
echo count