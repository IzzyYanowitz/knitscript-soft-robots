// I can't get three colors to work
// I want to make it work
// this is where I'm testing ideas

import cast_ons;

width = 50;
height = 50;
stripe_height = 2;

Carrier = c5;
cast_ons.alt_tuck_cast_on(width, is_front = True);

for _ in range(stripe_height): {
    in reverse direction: {
        knit Loops;
    }
}

Carrier = c2;

for _ in range(stripe_height): {
    in reverse direction: {
        knit Loops;
    }
}

Carrier = c5;
xfer Loops 3 to Right;
for _ in range(stripe_height): {
    in reverse direction: {
        knit Loops;
    }
}
xfer Loops 3 to Left;
for _ in range(stripe_height): {
    in reverse direction: {
        knit Loops;
    }
}

Carrier = c5;
Carrier = c2;
Carrier = c5;
Carrier = c2;
Carrier = c5;
