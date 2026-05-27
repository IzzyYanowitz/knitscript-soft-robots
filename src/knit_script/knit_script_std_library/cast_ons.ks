import needles;

def alt_tuck_cast_on(w, is_front=True, first_needle=0, co_dir=Leftward, tuck_lines=2, knit_lines=2, release=True):{
	// alt tuck cast on with a set width
	side = Back_Needles;
	if is_front:{
		side = Front_Needles;
	}
	first_pass = side[first_needle: first_needle + w: 2];
	second_pass = side[first_needle + 1: first_needle + w: 2];
	if w%2 == 0:{
		left_shifted_pass = side[first_needle: first_needle+w: 2];
		right_shifted_pass = side[first_needle + 1: first_needle+w: 2];
		if co_dir == Rightward:{ // needs to end on left shifted loop
			first_pass = left_shifted_pass;
			second_pass = right_shifted_pass;
		} else:{ // needs to end on right shifted loop
			first_pass = right_shifted_pass;
			second_pass = left_shifted_pass;
		}
	}
	print f"Cast on {w} loops from {first_needle} to {first_needle+w}";
	co_loops = [];
	for _ in range(0, tuck_lines):{
		in co_dir direction:{
			tuck first_pass;
		}
		co_loops = Last_Pass;
		in reverse direction:{
			tuck second_pass;
		}
		co_loops.extend(Last_Pass);
	}
	if release:{
		releasehook;
	}
	for k in range(0, knit_lines):{
		in reverse direction:{
			knit co_loops;
		}
		in reverse direction:{
			knit co_loops;
		}
	}
}

def alt_tuck_needle_set(co_needles, co_dir=Leftward):{
	// alt tuck cast on with a set of needles
	co_needles= needles.direction_sorted_needles(co_needles, co_dir);
    if co_dir == Leftward:{
        in co_dir direction:{
            tuck co_needles[1::2];
        }
        in reverse direction:{
            tuck co_needles[0::2];
        }
    } else:{
        in co_dir direction:{
            tuck co_needles[0::2];
        }
        in reverse direction:{
            tuck co_needles[1::2];
        }
    }
}

def all_needle_cast_on(w, first_needle=0, tuck_lines=2, knit_lines=1, cross=True):{
	fronts_tucks_1 = Front_Needles[first_needle: first_needle+w:2];
	backs_tucks_1 = Back_Needles[first_needle+1: first_needle+w:2];

	fronts_tucks_2 = Front_Needles[first_needle+1: first_needle+w:2];
	backs_tucks_2 = Back_Needles[first_needle: first_needle+w:2];
	print f"All needle cast on {w} needles (front and back) from {first_needle}";
	for _ in range(0, tuck_lines):{
		if fronts_tucks_1[-1] < backs_tucks_1[-1]:{ // tucks would start on back, unstable
			in Leftward direction:{
				tuck fronts_tucks_2;
				tuck backs_tucks_2;
			}
			in reverse direction:{
				tuck fronts_tucks_1;
				tuck backs_tucks_1;
			}
		} else: {
			in Leftward direction:{
				tuck fronts_tucks_1;
				tuck backs_tucks_1;
			}
			in reverse direction:{
				tuck fronts_tucks_2;
				tuck backs_tucks_2;
			}
		}
	}
	if cross:{
		for _ in range(0, knit_lines):{
			in reverse direction:{
				knit [l.opposite() for l in Last_Pass];
			}
			in reverse direction:{
				knit [l.opposite() for l in Last_Pass];
			}
		}
	} else:{
		for _ in range(0, knit_lines):{
			in reverse direction:{
				knit Front_Loops;
			}
			in reverse direction:{
				knit Back_Loops;
			}
		}
	}
}

def all_needle_wasted_cast_on(w, waste_yarn, thread_yarn, waste_size=10, first_needle=0):{
	//cast_on with waste_yarn
	with Carrier as waste_yarn:{
		in Leftward direction:{
			tuck Front_Needles[first_needle + w - 2];
		}
		in Leftward direction:{
			tuck Back_Needles[first_needle+1:first_needle+w:2];
			tuck Front_Needles[first_needle:first_needle+w:2];
		}
		for _ in range(0, 2):{
			in reverse direction:{
				knit Back_Loops;
			}
		}
		in reverse direction:{
			knit Front_Loops;
			tuck Back_Loops;
		}
		in reverse direction:{
			knit Back_Loops;
		}
		in reverse direction:{
			knit Front_Loops;
		}
		for _ in range(0, waste_size):{
			in reverse direction:{
				knit Front_Needles[first_needle: first_needle+w];
			}
			in reverse direction:{
				knit Back_Needles[first_needle: first_needle+w];
			}
		}
		cut waste_yarn;
	}
	with Carrier as thread_yarn:{
		in Leftward direction:{
			tuck Front_Needles[first_needle+w: first_needle + w +6];
			knit Front_Loops;
		}
		in reverse direction:{
			knit Back_Loops;
			tuck Back_Needles[first_needle+w: first_needle + w +6];
		}
		drop Front_Loops[-6::1];
		drop Back_Loops[-6::1];
		cut thread_yarn;
	}

}

def knit_cast_on(co_needles, co_dir = Leftward, extra_knits = 1, outhook = True): {
	
	// casts on using a method analgous to the standard cast on when knitting by hand
	if co_dir == Leftward: {
		co_needles = co_needles[ : : -1];
	}
	
	// tuck a needle a couple times to secure the thread in the correct spot
	
	in Leftward direction: {
		tuck co_needles[0];
	}
	in Rightward direction: {
		miss co_needles[0];
	}
	in Leftward direction: {
		tuck co_needles[0];
	}


	for needle in co_needles[1 : len(co_needles)]: {
		in co_dir direction: {
			miss needle;
		}
		in reverse direction: {
			tuck needle;
		}
		in co_dir direction: {
			miss needle;
		}
	}
	
	print f"Cast on {len(Loops)} loops from {co_needles[0]} to {co_needles[-1]}";
	
	for row in range(extra_knits): {
		row_direct = reverse;
		first = 1;
		last = len(co_needles);
		
		if row_direct == Rightward: {
			last = len(co_needles) - 1;
			first = 0;
		}
		
		in row_direct direction: {
			knit co_needles[first : last];
		}
		
	}
	if outhook: {
		releasehook;
	}
	
}

def backward_loop_with_waste(co_carr, waste_carr, width, shift = 15, waste_height = 10, extra_knits = 1): {
	// casts on the front bed with waste yarn
	// really only works with empty needle bed
	// sorry this is not a very versatile function
	// it also only kinda works...
	with Carrier as waste_carr: {
    	
		cast_ons.alt_tuck_cast_on(width + shift, is_front = True);
		
		in Leftward direction: {
			knit Loops[width : width + shift];
		}
		
		
		drop Loops[width : width + shift];
		
		for row in range(waste_height): {
			in reverse direction: {
				knit Loops;
			}
		}
		
		xfer Front_Loops[::2] across to Back bed;
		xfer Front_Loops 1 to Left;

	}

	with Carrier as co_carr: {
		cast_on_needles = [[Front_Needles, Back_Needles][i % 2][i] for i in range(width)];
		cast_ons.knit_cast_on(cast_on_needles, extra_knits = 0);

	}

	with Carrier as waste_carr: {
		in Leftward direction: {
			tuck Front_Needles[1:width:2];
		}
		drop Front_Needles[1:width:2];
		xfer Back_Needles[1:width:2] across;
		drop Back_Loops;
		
	}
	cut waste_carr;

	with Carrier as co_carr: {
		for row in range(extra_knits): {
			in [Rightward, Leftward][row % 2] direction: {
				knit Loops;
			}
		}
	}
}


//	in Leftward direction:{
//		tuck Front_Needles[first_needle:first_needle+w:2];
//		tuck Back_Needles[first_needle+1:first_needle+w:2];
//	}
//	in reverse direction:{
//		tuck Front_Needles[first_needle+1:first_needle+w:2];
//		tuck Back_Needles[first_needle:first_needle+w:2];
//	}
