// simple swatch of a garder stitch
import cast_ons;
width = 5;
height = 5;

with Gauge as 2, Carrier as c1: {
    
    // cast on

    
        cast_ons.alt_tuck_cast_on(width, is_front = True);
    
    
    for row in range(height): {
        
            
                // knit row
                in reverse direction: {
                    knit Loops; 
                }
                
                xfer Loops across; // IMPORTANT xfer does not go inside a direction block!!!
    }
}