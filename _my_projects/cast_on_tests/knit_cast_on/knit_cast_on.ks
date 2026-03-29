// this is most similar to a standard knitting cast on
import cast_ons;
import bind_offs;

carr = c1;
width = 30;
height = 30;


with Carrier as carr: {
    /*needles = Front_Needles[ : width];
     needles = needles[ : : -1];
    

    for needle in needles: {
        in Leftward direction: {
            miss needle;
        }

        in Rightward direction: {
            tuck needle;
        }

        in Leftward direction: {
            miss needle;
        }
    } */

    cast_ons.knit_cast_on(Front_Needles[ : width]);
    

    for row in range(height): {
        in reverse direction: {
            knit Loops;
        }
    }

    bind_offs.chain_bind_off(Loops, Leftward, hold = False);
}