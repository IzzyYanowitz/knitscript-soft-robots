// I adapted the pattern in this folder
// I found it free on ravelry
// i plan to add a red W on the front of this hat, but I want to test i can knit a hat first
import cast_ons;

carriers = [c1, c2]; // change to be black, red


// because of how i coded the decrease rounds, if you are gonna mess with any of these measurements
// you need to redo the decrease rounds
// i don't understand it well enough to automate this
head_circumference = 58; // cm 
ear_to_ear = 40; // cm (measured vertically)
gauge_x = 3.1; // st/cm
gauge_y = 4; // rows/cm

width = head_circumference * 0.9 * gauge_x; // stitches
width = int(width / 2); // to account for knitting in the round
height = (int(ear_to_ear / 2) + 5) * gauge_y; // stitches

brim_height = int(height / 3); // this will be folded in half
body_height = int(height * 0.36);

// i am skipping this weird way they knit the brim because i don't know how to do that...

with Carrier as carriers[0]: {
    // cast on front and back
    cast_ons.alt_tuck_cast_on(width, is_front = True);
    cast_ons.alt_tuck_cast_on(width, is_front = False);


    // brim
    for row in range(brim_height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }

    // body (this is placeholder code until I make the W)
    for row in range(brim_height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }

    // decrease rounds
    // idk figure this out
}


