// v2 does a few more stripes, repeating the same 2 colors. 
import cast_ons;
import stockinette;
import bind_offs;

beginning_height = 4;
stripe_height = 2;

with Carrier as c5, width as 10:{
    cast_ons.alt_tuck_cast_on(width);
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
    bind_offs.chain_bind_off(Loops, reverse, hold=False);             
}