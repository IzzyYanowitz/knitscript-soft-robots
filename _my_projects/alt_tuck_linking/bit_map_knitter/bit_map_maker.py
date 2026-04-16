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

hilbert = ["XXXX",
           "X  X",
           "X  X",
           "X  X"]

carpet = ["X"]

cardinal = ['               X       ', 
            '               XX      ', 
            '              XXXXX    ', 
            '               XXXX    ', 
            '              XXXXXX   ', 
            '              XXX| |X  ', 
            '             XXXX|||XX ', 
            '            XXXXXX||XXX', 
            '           XXXXXXXX|XX ', 
            '          XXXXXXXXXXX  ', 
            '         XXXXXXXXXXXX  ', 
            '         XXXXXXXXXXXX  ', 
            '        XXXXXXXXXXXXX  ', 
            '        XXXXXXXXXXXXX  ', 
            '       XXXXXXXXXXXXXX  ', 
            '       XXXXXXXXXXXXX   ', 
            '       XXXXXXXXXXXXX   ', 
            '       XXXXXXXXXXXX    ', 
            '      XXXXXXXXXXXX     ', 
            '    XXXXXXXXX X        ', 
            '   XXX    XXX XX       ', 
            '  XXXX      X  X       ', 
            ' XXXX      X XX X      ', 
            'XXXX           X XX    ', 
            'XXX                    ']


def reflect(drawing, dir):
    #dir = 1 reflects across major axis, -1 reflects across minor
    new_drawing = ['' for _ in range(len(drawing[0]))]
    for i in range(len(drawing[0])):
        for j in range(len(drawing)):
            if dir == 1:
                new_drawing[i] = new_drawing[i] + drawing[j][-i-1]
            if dir == -1:
                new_drawing[i] = new_drawing[i] + drawing[-j-1][i]
    return new_drawing
    

def rotate(drawing, dir):
    new_drawing = ['' for _ in range(len(drawing[0]))]
    for i in range(len(drawing[0])):
        for j in range(len(drawing)):
            if dir == 1:
                new_drawing[i] = new_drawing[i] + drawing[j][-i-1]
            elif dir == -1:
                new_drawing[i] = new_drawing[i] + drawing[-j-1][i]
    
    return new_drawing

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

def print_list(drawing):
    print("")
    for i in drawing:
        print(i)
    print("")

def next_hilbert(drawing): 
    drawing_l = rotate(drawing, 1)
    drawing_r = rotate(drawing, -1)
    
    new_drawing = ["" for i in range(2 * (len(drawing) + 1))]
    for i in range(len(drawing) - 1):
        new_drawing[i] = drawing[i] + '  ' + drawing[i]
    new_drawing[len(drawing) - 1] = drawing[len(drawing) - 1] + "XX" + drawing[len(drawing) - 1]
    for i in range(2):
        new_drawing[len(drawing) + i] = "X" + ' ' * 2 * len(drawing) + "X"
        
        
    for i in range(len(drawing)):
        new_drawing[2 + len(drawing) + i] = drawing_r[i] + '  ' + drawing_l[i]
    return new_drawing

def next_carpet(drawing):
    new_drawing = ["" for _ in range(3 * len(drawing))]
    
    for i in range(len(drawing)):
        new_drawing[i] = 3 * drawing[i]
    
    for i in range(len(drawing)):
        new_drawing[len(drawing) + i] = drawing[i] + len(drawing) * ' ' + drawing[i]

    for i in range(len(drawing)):
        new_drawing[2 * len(drawing) + i] = 3 * drawing[i]

    return new_drawing

for i in range(4):
    hilbert = next_hilbert(hilbert)
    carpet = next_carpet(carpet)

print_list(carpet)

for i in (get_bit_map(cardinal, symbols, True)):
    print(str(i) + ', ')

