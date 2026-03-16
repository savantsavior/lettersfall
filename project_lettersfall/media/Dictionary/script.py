letters = 'abcdefghijklmnopqrstuvwxyz'
allowed = list(letters + '\'' + '-')

with open("words.txt", "r", encoding='u8') as f:
  lines = f.read().splitlines()

# letter -> list of words starting with letter
letter_words_map: dict[str, list[str]] = {}

for word in lines:
  # filter out illegal characters
  filtered_word = ''.join(letter for letter in word if letter in allowed)
  if word != filtered_word:
    print(f"Word changed: {word} -> {filtered_word}")

  if filtered_word.startswith('\''):
    continue # skip

  if filtered_word.startswith('-'):
    continue # skip

  # skip completely illegal (empty) words
  if filtered_word == "":
    continue # skip

  # add word to correct list in the map
  starting_letter = filtered_word[0]
  if starting_letter not in letter_words_map.keys():
    letter_words_map[starting_letter] = [filtered_word,]
  else:
    letter_words_map[starting_letter].append(filtered_word)

# for each starting letter
for starting_letter in letter_words_map.keys():
  # create a new txt file consisting of each word starting with that letter
  with open(f'{starting_letter}.txt', 'w') as f:
    f.write(
      '\n'.join(
        letter_words_map[starting_letter]
      ) + '\n'
    )
