# draw a bit map using black and white emojis and it will convert it to 1s and zeros
# black as 1, white is 0 because its more like drawing...
symbols = [" ", "X", "|"] # white, orange, blue

smiley = ["          ",
           " XXX  XXX ",
           "          ",
           "  X    X  ",
           "          ",
           " X      X ",
           "  XXXXXX  "]



ghost = ["                ",
         "      XXXX      ",
         "    XXXXXXXX    ",
         "   XXXXXXXXXX   ",
         "  XXX  XXXX  X  ",
         "  XX    XX    X ",
         "  XX  ||XX  ||X ",
         " XXX  ||XX  ||X ",
         " XXXX  XXXX  XX ",
         " XXXXXXXXXXXXXX ",
         " XXXXXXXXXXXXXX ",
         " XXXXXXXXXXXXXX ",
         " XXXXXXXXXXXXXX ",
         " XX XXX  XXX XX ",
         " X   XX  XX   X ",
         "                "]



def get_bit_map(drawing, symbols, do_flip):
    flipped_drawing = []
    if do_flip: 
        for row in drawing:
            flipped_drawing = [row] + flipped_drawing
        drawing = flipped_drawing
    bit_map = []
    variation_selector = "️" # this is not an empty string, its an invisible character
    for i, row in enumerate(drawing):
        bit_map.append([])
        for j, char in enumerate(row):
            
            if char in symbols:
                bit_map[i].append(symbols.index(char))
            else:
                print("I don't know", char, "at", i, j)
                quit()
    return bit_map

print(get_bit_map(ghost, symbols, True))