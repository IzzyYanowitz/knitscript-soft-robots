// this makes the finger. Gauge is fixed
import bind_offs;

width_gauge = 4.5; // st/cm
height_gauge = 6.8; // st/cm

def cm_to_sts(dimensions): {
    // converts a length two array [width, height] in cm to stitches
    return [int(dimensions[0] * width_gauge), int(dimensions[1] * height_gauge)];
}

def make_finger(left_side_index, dimensions): {
    // makes a finger 
    // dimensions is [width, height]
    // The width and height should be in stitches.


    
    width = dimensions[0];
    height = dimensions[1];
    left_side_index = left_side_index + int(width/2);
    right_side_index = left_side_index + 1;

    
   
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

    // make fingertip
    current_width = 2;
    while current_width < width: {
        // there has to be weird racking to get the splits to work
        
        
        
        // rack over to split then rack back
        
        
        Racking = 1.0; // front bed is 1 right
        
        in Leftward direction: {
            split Front_Needles[right_side_index];
        }
        
        
        Racking = 0.0; // front bed is aligned
        
        print(Back_Needles[right_side_index + 1]);
        xfer Back_Needles[right_side_index + 1] across;
        
        // knit normal needles
        in Leftward direction: {
            knit Front_Needles[right_side_index + 1]; // this just finishes the increase
            knit Front_Needles[left_side_index + 1 : right_side_index];
        }

        // rack over to split then rack back
        Racking = -1.0; // front bed is 1 left
        in Leftward direction: {
            split Front_Needles[left_side_index];
        }
        Racking = 0.0; // front bed is aligned
        xfer Back_Needles[left_side_index - 1] across;

        // finish the increase
        in Leftward direction: {
            knit Front_Needles[left_side_index - 1];
        }


        // rack over to split then rack back
        Racking = 1.0; // back bed is 1 left
        in Rightward direction: {
            split Back_Needles[left_side_index];
        }
        Racking = 0.0; // back bed is aligned
        
        xfer Front_Needles[left_side_index - 1] across;
        
        // knit normal needles
        in Rightward direction: {
            knit Back_Needles[left_side_index - 1]; // finish the increase
            knit Back_Needles[left_side_index + 1 : right_side_index];
        }
        
        // rack over to split then rack back
        Racking = -1.0; // back bed is 1 right
        in Rightward direction: {
            split Back_Needles[right_side_index];
        }
        Racking = 0.0;
        xfer Front_Needles[right_side_index + 1] across;
        
        // finish the increase
        in Rightward direction: {
            knit Back_Needles[right_side_index + 1];
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
    

    make_finger(left_side_index = 0, dimensions = finger_dims["pinky"]);
}