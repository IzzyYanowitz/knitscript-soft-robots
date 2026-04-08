// v4 experiments with more carriers. more carriers throw Inserting_Hook_In_Use_Error. 
import cast_ons;
import stockinette;
import bind_offs;

stripe_height = 2;

with Carrier as c5, width as 10:{
    // by default, this cast on knits 2 rows after the tucks. 
    cast_ons.alt_tuck_cast_on(width, first_needle=20, knit_lines=2);
}

with Carrier as c4:{
    stockinette.stst(stripe_height+5);  
}
        
with Carrier as c1:{
    stockinette.stst(stripe_height);  
    bind_offs.chain_bind_off(Loops, reverse, hold=False);             
}
