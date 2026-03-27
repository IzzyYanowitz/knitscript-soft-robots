// this makes the finger. Gauge is fixed
import bind_offs;

width_gauge = 4.5; // st/cm
height_gauge = 6.8; // st/cm

def make_finger(left_side_index, width, height): {
    // makes a finger. The width and height should be in cm.

    // tuck a random needle to get the yarn inserting hook out of the way

    


    // adjusts width and height to be in stitches
    width = int(width * width_gauge);
    height = int(height * height_gauge);
    left_side_index = left_side_index + int(width/2);
    right_side_index = left_side_index + 1;

    in Leftward direction: {
        tuck Back_Needles[width + 1];
    }
    drop Back_Needles[width + 1];
   
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
        // move out left side
        xfer Front_Loops[0] 1 to Left;
        xfer Back_Loops[0 : 2] across to Front bed; // xfers both previously moved loop and outermost back loop across
        xfer Front_Loops[1] 1 to Left;

        // move out rightside
        xfer Front_Loops[-1] 1 to Right;
        xfer Back_Loops[-2 : len(Back_Loops)] across to Front bed; // xfers both previously moved loop and outermost back loop across
        xfer Front_Loops[-2] 1 to Right;


        left_side_index = left_side_index - 1;
        right_side_index = right_side_index + 1;
        current_width = current_width + 2;

        // knit front and back while tucking empty needle
        in Leftward direction: {
            knit Front_Needles[left_side_index];
            tuck Front_Needles[left_side_index + 1];
            knit Front_Needles[left_side_index + 2 : right_side_index - 1];
            tuck Front_Needles[right_side_index - 1];
            knit Front_Needles[right_side_index];
        }

        in Rightward direction: {
            knit Back_Needles[right_side_index];
            tuck Back_Needles[right_side_index - 1];
            knit Back_Needles[left_side_index + 2 : right_side_index - 1];
            tuck Back_Needles[left_side_index + 1];
            knit Back_Needles[left_side_index];
        }
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

with Carrier as c1: {
    make_finger(left_side_index = 0, width = 4, height = 7.5);
}