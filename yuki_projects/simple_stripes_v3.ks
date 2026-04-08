// v3 knits on needles that aren't at the start of the bed. 

import cast_ons;
import stockinette;
import bind_offs;

beginning_height = 4;
stripe_height = 2;

with Carrier as c5, width as 10:{
    // by default, this cast on knits 2 rows after the tucks. 
    cast_ons.alt_tuck_cast_on(width, first_needle=40, knit_lines=2);
    stockinette.stst(beginning_height);  
}

with Carrier as c4:{
    stockinette.stst(stripe_height);  
}
        
with Carrier as c5:{
    stockinette.stst(stripe_height);  
}

with Carrier as c4:{
    stockinette.stst(stripe_height);  
}

with Carrier as c5:{
    stockinette.stst(stripe_height);  
}

with Carrier as c4:{
    stockinette.stst(stripe_height);  
    bind_offs.chain_bind_off(Front_Loops, reverse, hold=False);        
}
