# draw a bit map using black and white emojis and it will convert it to 1s and zeros
# black as 1, white is 0 because its more like drawing...

drawing = ["⬜️⬜️⬜️⬜️⬜️⬜️⬜️",
           "⬜️⬛⬛️⬜️⬛️⬛️⬜️",
           "⬛⬛⬛⬛⬛⬛⬛",
           "⬛⬛⬛⬛⬛⬛⬛",
           "⬜️⬛⬛⬛⬛⬛⬜️",
           "⬜️⬜️⬛⬛⬛⬜️⬜️",
           "⬜️⬜️⬜️⬛⬜️⬜️⬜️",]
bit_map = []
variation_selector = "️" # this is not an empty string, its an invisible character
for i, row in enumerate(drawing):
    bit_map.append([])
    for j, char in enumerate(row):
        if char == variation_selector:
            continue
        elif char == "⬜":
            bit_map[-1].append(0)
        elif char == "⬛":
            bit_map[-1].append(1)
        else:
            print("I don't know", char, "at", i, j)
            quit()
print(bit_map)
