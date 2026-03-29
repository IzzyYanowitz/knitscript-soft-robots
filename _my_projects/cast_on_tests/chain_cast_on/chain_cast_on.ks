import bind_offs;

// this cast on echoes the chain bind off
// i don't know if this would ever be useful becasue it would be really unstretchy
// weird number of split threads with this method

carr = c1;
width = 30;
height = 30;

with Carrier as carr: {
    
    needles = [i for i in range(width - 1, 0, -1)];
    
    in Leftward direction: {
        tuck Front_Needles[width];
    }

    for needle in needles: {
        xfer Front_Needles[needle] 1 to Left;
        xfer Back_Needles[needle - 1] across;
        
        in Leftward direction: {
            split Front_Needles[needle - 1];
        }

        xfer Back_Needles[needle - 1] 1 to Right;
    

    }
    xfer Back_Needles across; // this makes sure any split threads get put back in place
    
    // note at the end of this, the carrier will be on the right side of the piece
    for row in range(height): {
        in reverse direction: {
            knit Loops;
        }
    }

    bind_offs.chain_bind_off(Loops, Rightward, hold = False);
}