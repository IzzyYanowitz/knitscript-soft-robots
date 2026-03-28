// this makes the finger. Gauge is fixed

def make_finger(left_side_index, dimensions): {
    
    // makes a finger  
    // dimensions is [width, height]
    // the width and height should be in stitches
    
    // extract dimensions
    width = dimensions[0];
    height = dimensions[1];

    // the index of the left and right sides of the piece
    // used during the increase rounds because the increases always happen on the edges 
    left_side_index = left_side_index + int(width/2) + 1; // just starting a bit to the right to leave space
    right_side_index = left_side_index + 1;
    current_width = 2;


    // this just makes sure the yarn inserting hook is out of the way
    
    in Leftward direction: {
        tuck Back_Needles[width + 2];
    }
    drop Back_Needles[width + 2];


    // You start by alt_tuck casting on 4 stitches that will be the tip of the finger
    starting_needles = [Front_Needles[left_side_index], 
                        Front_Needles[left_side_index + 1],
                        Back_Needles[left_side_index + 1],
                        Back_Needles[left_side_index]];

    
    // cast on
    in Leftward direction: {
        tuck starting_needles[ : : 2];
    }
    in Rightward direction: {
        tuck starting_needles[1: : 2];
    }

    // make tip of the finger

    
    while current_width < width: {
        print(Loops);
        // racking doesn't seem to work so I am doing something much much slower with xfers.
        // this basically has to move each stitch out of the way before increasing it
        // this increase itself is pretty simple. You split a stitch, then move the old stitch to the outside
        // finally you knit the old stitch to keep it in line with the new line of stitches

        // right front increase
        xfer Front_Needles[right_side_index] 1 to Right;
        xfer Back_Needles[right_side_index + 1] across;

        in Leftward direction: {
            split Front_Needles[right_side_index + 1];
        }
        xfer Back_Needles[right_side_index + 1] 1 to Left;

        // knit normal needles
        in Leftward direction: {
            
            knit Front_Needles[left_side_index + 1 : right_side_index + 1]; // skip the last stitch and finish the increase
        }


        // left front increase
        xfer Front_Needles[left_side_index] 1 to Left;
        xfer Back_Needles[left_side_index - 1] across;

        in Leftward direction: {
            split Front_Needles[left_side_index - 1];
        }
        
        xfer Back_Needles[left_side_index - 1] 1 to Right;

        in Leftward direction: {
            knit Front_Needles[left_side_index]; // finishes increase
        }

        
        // now do the back side
        // this has to be slightly different to avoid interfering with the new loops
        
        // back left increase
        // move new loops out of the way
        xfer Front_Needles[left_side_index - 1] 1 to Left;
        
        xfer Back_Needles[left_side_index] 1 to Left;
        xfer Front_Needles[left_side_index - 1] across;
        
        in Rightward direction: {
            split Back_Needles[left_side_index - 1];
        }
        xfer Front_Needles[left_side_index - 1] 1 to Right;
        // return former front loop
        xfer Back_Needles[left_side_index - 2] 1 to Right;

        // knit normal loops
        in Rightward direction: {
            
            knit Back_Needles[left_side_index : right_side_index]; // makeing sure to finish the increase and skip last loop
        }

        // back right increase
        // move new loop out of the way
        xfer Front_Needles[right_side_index + 1] 1 to Right;

        xfer Back_Needles[right_side_index] 1 to Right;
        xfer Front_Needles[right_side_index + 1] across;

        in Rightward direction: {
            split Back_Needles[right_side_index + 1];
        }
        xfer Front_Needles[right_side_index + 1] 1 to Left;
        // move back new Loop
        xfer Back_Needles[right_side_index + 2] 1 to Left;
        
        // finish increase
        in Rightward direction: {
            knit Back_Needles[right_side_index];
        }
        
        

        left_side_index = left_side_index - 1;
        right_side_index = right_side_index + 1;
        current_width = current_width + 2;
    }

    // knit main body of finger
    for row in range(height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }

    

}

def cm_to_sts(dimensions): {
    // converts a length two array [width, height] in cm to stitches
    return [int(dimensions[0] * width_gauge), int(dimensions[1] * height_gauge)];
}

width_gauge = 4.5; // st/cm
height_gauge = 6.8; // st/cm

finger_dims = {"thumb": [4, 5.5],
               "index": [3.5, 7],
               "middle": [3.75, 7.5],
               "ring": [3.25, 7],
               "pinky": [3,5.5]};

total_width = 0;

// convert finger_dims to stitch counts and find total width
for finger in finger_dims: {
    finger_dims[finger] = cm_to_sts(finger_dims[finger]);
    total_width = total_width + finger_dims[finger][0];
}

with Carrier as c1: {
    make_finger(left_side_index = 0, dimensions = finger_dims["index"]);
}