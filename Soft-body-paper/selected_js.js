var knitout = require('../../knitout-frontend-js/knitout');
k = new knitout.Writer({carriers:["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]});
var gauge = "half";
k.addHeader('Machine','SWGXYZ');
k.addHeader('Gauge','15');
k.addHeader('Presser','On');
k.addHeader('X-Presser','On');

var title = "pullstrings";
var frontYarn = "3";
var pullstring = "5";
var backYarn = "8";
var secondPullstring = "7";
var middleYarn = "6";
var carriers = {};  // will be used to store carrier state

var tuckDist = 3;

var height = 100;
var width = 15;
var confines = {leftedge:1, rightedge: width, side: "tube"};

k.stitchNumber(95);

// ====== Start  =======
	// lampshade();
	// tentacle();
	// scrunchScarf();
	singleVertPrimitive();

// ====== finish specific object =======

console.log("Processed "+title);
k.write(title+'.k');


// // ================================================================= 
// // ======================= ~ Demos ~ ========================== 
// // ================================================================= 
function lampshade () {
	// parameters to control width, length, size of pockets, number of segments, etc
	confines = {leftedge:0, rightedge: 100, side: "f"};
	var ribHeight = 6;
	var drapeHeight = 4*ribHeight;
	var drapeWidth = 70;
	var lapWidth = 15;
	var numberOfSegments = 6;
	var pocket = {rightedge: confines.rightedge, leftedge: confines.rightedge - drapeWidth, side: "b"};
	confines.rightedge = confines.rightedge + lapWidth;
	var weaveFunction = function (s) {return ((s%2 == 0 && s>pocket.leftedge) || s>pocket.rightedge) ? "p" : "k";}

	var webbingFunction = function (confines, height, h) {
		// var width = confines.rightedge - confines.leftedge;
		var width = 1 + (pocket.rightedge - pocket.leftedge);
		var stepSize = width/((height/2) - 1);
		var leftedge = confines.leftedge;
		var rightedge;
		if (h<height/2) {
			rightedge = Math.floor(pocket.rightedge - (h*stepSize));
		}
		else {
			rightedge = Math.floor(pocket.leftedge + ((h-height/2)*stepSize));
		}
		return {rightedge: rightedge, leftedge: leftedge, side: "f"};
	}

	var	shortRows = function (height, confines, side, carrier, rowsFunction, tuckEdges) {
		var bed = side;
		var otherBed = (bed == "f") ? "bs" : "fs";
		for (var h=0; h<height; h++) {
			if (h == Math.round(height/2)) {
				reversePlainRows(2, confines, carrier);
			}
			shortConfines = rowsFunction(confines, height, h);
			if (tuckEdges && shortConfines.leftedge > confines.leftedge) {
				tuck("-", bed, shortConfines.leftedge - 1, carrier);
			}
			for (var s=shortConfines.leftedge; s<=shortConfines.rightedge; s++) {
				knit("+", bed, s, carrier);
			}
			if (tuckEdges && shortConfines.rightedge < confines.rightedge) {
				tuck("+", bed, shortConfines.rightedge + 1, carrier);
			}
			for (var s=shortConfines.leftedge; s<=shortConfines.rightedge; s++) {
				xfer(bed, s, otherBed, s);
			}
			for (var s=shortConfines.rightedge; s>=shortConfines.leftedge; s--) {
				// console.log(h, s);
				knit("-", otherBed, s, carrier);
			}
			for (var s=shortConfines.leftedge; s<=shortConfines.rightedge; s++) {
				xfer(otherBed, s, bed, s);
			}
		}
	}

	function pocketRows (numberOfRows, confines, pocket, frontYarn, backYarn) {
		for (var h=0; h<numberOfRows; h++) {
			for (var s=pocket.rightedge; s>=pocket.leftedge; s--) {
				knit("-", "b", s, backYarn);
			}
			tuck("+", "f", pocket.leftedge, backYarn);
			for (var s=pocket.leftedge; s<=pocket.rightedge; s++) {
				knit("+", "b", s, backYarn);
			}


			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				knit("+", "f", s, frontYarn);
			}
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				xfer("f", s, "bs", s);
			}
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				knit("-", "bs", s, frontYarn);
			}	
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				xfer("bs", s, "f", s);
			}	
		}
	}


	// "reverse" rows (caston/plain/purl) are reversed left/right -- the lamp is knit mirrored 
	// for faster yarn in/out and no vertical yarn tangling considerations.
	function reverseCaston (confines, carrier) {
		var bed = confines.side;
		if (!carriers[carrier] || !carriers[carrier].in) {
			yarnIn(carrier);
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			if (s%2 == confines.leftedge%2) {
				knit("+", bed, s, frontYarn);
			}
		}
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			if (s%2 != confines.leftedge%2) {
				knit("-", bed, s, frontYarn);
			}
		}
		if (carriers["hook"]) {
			releaseHook(carrier);
		}
	}

	function reversePlainRows (numberOfRows, confines, carrier) {
		for (var h=0; h<numberOfRows; h++) {
			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				// console.log(h, s);
				knit("+", "f", s, carrier);
			}
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				// console.log(h, s);
				knit("-", "f", s, carrier);
			}
		}
	}

	function reversePurlRows (numberOfRows, confines, carrier, keepOnBack) {
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			xfer("f", s, "bs", s);
		}
		for (var h=0; h<numberOfRows; h++) {
			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				// console.log(h, s);
				knit("+", "bs", s, carrier);
			}
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				// console.log(h, s);
				knit("-", "bs", s, carrier);
			}
		}
		if (!keepOnBack) {
			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				xfer("bs", s, "f", s);
			}
		}
	}

	function pocketStart (confines, pocket, carrier) {
			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				knit("+", "bs", s, carrier);
				if (s<=pocket.rightedge && s>=pocket.leftedge) {
					knit("+", "b", s, carrier);
				}
			}
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				if (s<=pocket.rightedge && s>=pocket.leftedge) {
					knit("-", "b", s, carrier);
				}
				knit("-", "bs", s, carrier);
			}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			xfer("bs", s, "f", s);
		}
	}

	// set up main yarns and do a begining flange/hem
	reverseCaston(confines, frontYarn);
	reversePlainRows(1, confines, frontYarn);
	reversePurlRows(5, confines, frontYarn);
	var backInTucks = tuckIn(backYarn, confines.rightedge + 3);

	// then for each segment...
	for (var i = 0; i<numberOfSegments; i++) {
		reversePurlRows(1, confines, frontYarn, true);

		// make the first half of the pocket
		pocketStart(confines, pocket, frontYarn);
		pocketRows(ribHeight/2, confines, pocket, frontYarn, backYarn, false, false);
		if (i==0) {
			dropAll(backInTucks);
		}

		// bring the drawstring carrier in and interlace it
		splitRow(confines, "f", weaveFunction);
		var inTucks = tuckIn(pullstring, confines.rightedge + 20);
		var overTucks = tuckTo(pullstring, "f", pocket.leftedge, true);
		rejoinRow(confines, "f", weaveFunction);
		dropAll(overTucks);
		drop("f", confines.rightedge +3);

		// one more row of pocket
		pocketRows(1, confines, pocket, frontYarn, backYarn, false, false);

		// bring the drawstring back the other way (double it over)
		splitRow(confines, "f", weaveFunction);
		overTucks = tuckTo(pullstring, "f", confines.rightedge + 20, true);
		rejoinRow(confines, "f", weaveFunction);

		// cut the drawstring and take the carrier out
		yarnOut(pullstring);
		dropAll(overTucks);
		dropAll(inTucks);

		// finish the pocket
		pocketRows(ribHeight/2, confines, pocket, frontYarn, backYarn, false, false);

		for (var s=pocket.rightedge; s>= pocket.leftedge; s--) {
			xfer("b", s, "f", s);
		}
		// then a hinge and the webbing wedge
		reversePurlRows(2, confines, frontYarn);
		shortRows(drapeHeight, confines, "f", frontYarn, webbingFunction, true);

	}

	// remove the pocket yarn and do an end flange/hem
	yarnOut(backYarn);
	reversePurlRows(5, confines, frontYarn);

	// knit back rightward so we can use the normal leftward bindoff
	for (var s=confines.leftedge; s<=confines.rightedge; s++) {
		knit("+", "f", s, frontYarn);
	}
	bindoff("stretchy", confines, frontYarn);

	title = "lampshade";
}

function tentacle () {
	// a three-string tentacle.
	confines = {leftedge: 0, rightedge: 18, side: "tube"};

	// even space the strings around the circumberence of the tube
	var circ = 2*(1+confines.rightedge - confines.leftedge);
	var spacing = Math.round(circ/3);
	var firstStringLocation = confines.rightedge - 1; // f
	var secondStringLocation = confines.rightedge - spacing + 1; // b
	var thirdStringLocation = confines.rightedge - spacing - 1; // f
	var thirdPullstring = 4;

	// cast on and set up all six yarns
	caston("tube", confines, middleYarn);
	knitRows(1, confines, "tube", middleYarn);
	var inTucks = tuckIn(backYarn, confines.rightedge + 1);
	knitRows(1, confines, "tube", backYarn);
	dropAll(inTucks);
	var inTucks = tuckIn(frontYarn, confines.rightedge + 1);
	knitRows(1, confines, "tube", frontYarn);
	dropAll(inTucks);

	inTucks = tuckIn(pullstring, confines.leftedge - 1);
	tuckTo(pullstring, "f", firstStringLocation, false);
	dropAll(inTucks);
	inTucks = tuckIn(secondPullstring, confines.rightedge + 1);
	tuckTo(secondPullstring, "b", secondStringLocation, false);
	dropAll(inTucks);
	inTucks = tuckIn(thirdPullstring, confines.rightedge + 1);
	tuckTo(thirdPullstring, "f", thirdStringLocation, false);
	dropAll(inTucks);


	// call main two-pullstring-bed function
	knitWithTwoVertPullstrings(height, confines, frontYarn, middleYarn, backYarn);

	// bring the pullstrings out gracefully (leave some extra length)
	var outTucks = tuckOut(pullstring, confines.rightedge + 10);
	outTucks = outTucks.concat(tuckOut(secondPullstring, confines.rightedge + 10));
	outTucks = outTucks.concat(tuckOut(thirdPullstring, confines.rightedge + 10));
	outTucks.sort(function (a, b) {return b.needle - a.needle; });
	dropAll(outTucks);
	yarnOut(frontYarn);
	yarnOut(backYarn);

	// taper the top of the tentacle using inc/dec shaping
	while (1 + confines.rightedge - confines.leftedge > 5) {
			confines.rightedge = moveChunk({rightedge: confines.rightedge, leftedge: confines.rightedge - 1, side: "tube"}, -1).rightedge;
			confines.leftedge = moveChunk({leftedge: confines.leftedge, rightedge: confines.leftedge + 1, side: "tube"}, 1).leftedge;
			knitRows(2, confines, "tube", middleYarn);
	}

	bindoff("closed", confines, middleYarn);

	title = "tentacle";
}

function scrunchScarf () {
	// manually scrunchable? a dense grid of strings?
	function weaveManeuver (confines, pullstring, mainYarn) {
		// tuck in drawstring
		var weaveFunction = function (s) {return (s%2 == 0) ? "k" : "p";}

		splitRow(confines, "f", weaveFunction);
		var inTucks = tuckIn(pullstring, confines.rightedge + 8);
		var overTucks = tuckTo(pullstring, "f", confines.leftedge - 3, true);
		
		rejoinRow(confines, "f", weaveFunction);
		dropAll(overTucks);

		drop("f", confines.leftedge - 3);
		knitLeft(confines, "f", mainYarn);
		knitRight(confines, "f", mainYarn);

		splitRow(confines, "f", weaveFunction);
		overTucks = tuckTo(pullstring, "f", confines.rightedge + 8, true);
		rejoinRow(confines, "f", weaveFunction);
		dropAll(overTucks);
		yarnOut(pullstring);
		dropAll(inTucks);
	}

	var bumpWidth = 20;
	var stepSize = 1;

	function bottomShortRows (confines, carrier, rowOffset) {
		var numberOfBumps = (confines.rightedge - confines.leftedge)/bumpWidth;
		for (var i = 0-rowOffset; i<numberOfBumps; i++) {
			var miniConfines = {rightedge: confines.rightedge - i*bumpWidth, leftedge: confines.rightedge - (i+1)*bumpWidth};
			var s;
			for (var h=0; h<(bumpWidth/2)/stepSize; h++) {
				for (s = miniConfines.rightedge - h*stepSize; s>miniConfines.leftedge + h*stepSize; s--) {
					if (s>=confines.leftedge && s<=confines.rightedge)knit("-", "f", s, carrier);
				}
				if (s>=confines.leftedge && s<=confines.rightedge) tuck("+", "f", miniConfines.leftedge + h*stepSize, carrier);
				for (s = s+1; s<miniConfines.rightedge - h*stepSize; s++) {
					if (s>=confines.leftedge && s<=confines.rightedge)knit("+", "f", s, carrier);
				}
				if (s<miniConfines.rightedge) {
					if (s>=confines.leftedge && s<=confines.rightedge)tuck("-", "f", s, carrier);
				}
			}
			for (s = s - 1; s>miniConfines.leftedge; s--) {
				if (s>=confines.leftedge && s<=confines.rightedge) knit("-", "f", s, carrier);
			}
			
		}
		if (s>=confines.leftedge) knit("-", "f", confines.leftedge, carrier);
		knitRight(confines, "f", carrier);
	}

	function topShortRows (confines, carrier, rowOffset) {
		var numberOfBumps = (confines.rightedge - confines.leftedge)/bumpWidth;
		var s = confines.rightedge;
		for (var i = 0-rowOffset; i<numberOfBumps; i++) {
			var miniConfines = {rightedge: confines.rightedge - i*bumpWidth, leftedge: confines.rightedge - (i+1)*bumpWidth};
			for (var h=(bumpWidth/2)/stepSize; h>0; h--) {
				if (s<miniConfines.rightedge && s<confines.rightedge && h<((bumpWidth/2)/stepSize)-1) {
					tuck("-", "f", s+1, carrier);
				}
				for (s; s>miniConfines.leftedge + h*stepSize; s--) {
					if (s>=confines.leftedge && s<=confines.rightedge) knit("-", "f", s, carrier);
				}
				if (s>=confines.leftedge  && s<=confines.rightedge && (h < (bumpWidth/2)/stepSize)) tuck("+", "f", s, carrier);
				for (s = s+1; s<miniConfines.rightedge - h*stepSize; s++) {
					if (s>=confines.leftedge && s<=confines.rightedge) knit("+", "f", s, carrier);
				}
				s--;
			}	
		}
		tuck("-", "f", s+1, carrier);
		for (s; s>=confines.leftedge; s--) {
			knit("-", "f", s, carrier);
		}
		// knit("-", "f", confines.leftedge, carrier);
		knitRight(confines, "f", carrier);
	}

	function knitLeft (confines, bed, carrier) {
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			knit("-", bed, s, carrier);
		}
	}
	function knitRight (confines, bed, carrier) {
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			knit("+", bed, s, carrier);
		}
	}

	scarf = {leftedge:0, rightedge: 100, side:"f"};
	caston("tuck", scarf, middleYarn);
	knitRows(3, scarf, "f", middleYarn, false);
	for (var h=0; h<10; h++) {
		bottomShortRows(scarf, middleYarn, 0);
		// knitLeft(scarf, "f", middleYarn);
		weaveManeuver(scarf, pullstring, middleYarn);
		// knitRight(scarf, "f", middleYarn);
		topShortRows(scarf, middleYarn, 0.5);
		knitRows(1, scarf, "f", middleYarn, false);

		bottomShortRows(scarf, middleYarn, 0.5);
		// knitLeft(scarf, "f", middleYarn);
		weaveManeuver(scarf, pullstring, middleYarn);
		// knitRight(scarf, "f", middleYarn);
		topShortRows(scarf, middleYarn, 0);
		knitRows(1, scarf, "f", middleYarn, false);
	}
	knitRows(3, scarf, "f", middleYarn, false);
	// bindoff("stretchy", scarf, middleYarn);
	yarnOut(middleYarn);
	title = "scarf";
}

function singleVertPrimitive (factor) {
	if (factor) {
		confines.rightedge = Math.round(factor*width);
	}
	caston("tube", confines, frontYarn);
	knitRows(1, confines, "tube", frontYarn);
	var inTucks = tuckIn(backYarn, confines.rightedge + 1);
	knitRows(1, confines, "tube", backYarn);
	dropAll(inTucks);

	var midpoint = Math.round((confines.rightedge+confines.leftedge)/2);
	inTucks = tuckIn(pullstring, confines.rightedge + 1);
	tuckTo(pullstring, "f", midpoint, false);
	dropAll(inTucks);

	knitWithVertPullstring(height/2, confines, "f", frontYarn, backYarn);

	tuckOut(pullstring, confines.rightedge + 10);
	yarnOut(frontYarn);
	fingertip(confines, backYarn);
	bindoff("closed", confines, backYarn);
	title = "singleVert";
}


// // ================================================================= 
// // ======================= ~ High-Level ~ ========================== 
// // ================================================================= 

function knitWithVertPullstring (height, confines, pullstringSide, frontCarrier, backCarrier) {
	var sameCarrier = (pullstringSide == "f") ? frontCarrier : backCarrier;	
	var oppCarrier = (pullstringSide == "f") ? backCarrier : frontCarrier;
	var oppSide = (pullstringSide == "f") ? "b" : "f";
	for (var h=0; h<height; h++) {
		if (h%2 == 0) {
			knitRows(1, confines, pullstringSide, sameCarrier, true);
			knitRows(1, confines, oppSide, oppCarrier, true);		
		}
		else {
			knitRows(2, confines, "tube", oppCarrier);
		}
	}
}

function knitWithTwoVertPullstrings (height, confines, frontCarrier, middleCarrier, backCarrier) {
	for (var h=0; h<height/2; h++) {
		if (h%2 == 0) {
			knitRows(1, confines, "f", frontCarrier, true);
			knitRows(1, confines, "b", backCarrier, true);		
		}
		else {
			knitRows(2, confines, "tube", middleCarrier);
		}
	}
}


// // ================================================================= 
// // ========================= ~ Helpers ~ =========================== 
// // ================================================================= 

// Primarily row-level functions, such as cast-ons, basic short rows, and
// functions that tuck across a row.

function knitRows (height, confines, side, carrier, tuckEdges) {
	if (side == "tube") {
		for (var h=0; h<height; h++) {
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				// console.log(h, s);
				knit("-", "f", s, carrier);
			}
			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				// console.log(h, s);
				knit("+", "b", s, carrier);
			}
		}
	}
	else {
		var bed = side;
		for (var h=0; h<height; h++) {
			if (tuckEdges && side == "b") {
				tuck("+", "f", confines.rightedge, carrier);
			}
			for (var s=confines.rightedge; s>=confines.leftedge; s--) {
				// console.log(h, s);
				knit("-", bed, s, carrier);
			}
			if (tuckEdges && side == "f") {
				tuck("+", "b", confines.leftedge, carrier);
			}
			for (var s=confines.leftedge; s<=confines.rightedge; s++) {
				// console.log(h, s);
				knit("+", bed, s, carrier);
			}
		}
	}
}

function garterRows (numberOfRows, confines, carrier) {
	for (var h=0; h<numberOfRows; h++) {
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			knit("-", "f", s, carrier);
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			xfer("f", s, "bs", s);
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			knit("+", "bs", s, carrier);
		}	
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			xfer("bs", s, "f", s);
		}	
	}
}

function knitShortRows (height, confines, side, carrier, rowsFunction, tuckEdges) {
	var bed = side;
	for (var h=0; h<height; h++) {
		shortConfines = rowsFunction(confines, h);
		if (tuckEdges && shortConfines.rightedge < confines.rightedge) {
			tuck("+", bed, shortConfines.rightedge + 1, carrier);
		}
		for (var s=shortConfines.rightedge; s>=shortConfines.leftedge; s--) {
			// console.log(h, s);
			knit("-", bed, s, carrier);
		}
		if (tuckEdges && shortConfines.leftedge > confines.leftedge) {
			tuck("+", bed, shortConfines.leftedge - 1, carrier);
		}
		for (var s=shortConfines.leftedge; s<=shortConfines.rightedge; s++) {
			// console.log(h, s);
			knit("+", bed, s, carrier);
		}
	}
}

function knitRowToStitch(confines, bed, stitch, carrier) {
	// basic function that assumes this is a tube
	if (bed == "b") {
		for (var s = confines.rightedge; s>=confines.leftedge; s--) {
			knit("-", "f", s, carrier);
		}
		for (var s=confines.leftedge; s<=stitch; s++) {
			knit("+", "b", s, carrier);
		}	
	}
	else if (bed == "f") {
		for (var s = confines.rightedge; s>=stitch; s--) {
			knit("-", "f", s, carrier);
		}
	}
}

function knitRowFromStitch(confines, bed, stitch, carrier) {
	// basic function that assumes this is a tube and the start stitch is on the back bed
	if (bed == "b") {
		for (var s=stitch; s<=confines.rightedge; s++) {
			knit("+", "b", s, carrier);
		}
	}
	else if (bed == "f") {
		for (var s = stitch; s>=confines.leftedge; s--) {
			knit("-", "f", s, carrier);
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			knit("+", "b", s, carrier);
		}
	}
}

function caston (style, confines, carrier) {
	if (!carriers[carrier] || !carriers[carrier].in) {
		yarnIn(carrier);
	}
	if (style == "tube") {
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			if (s%2 == confines.rightedge%2) {
				knit("-", "f", s, carrier);
			}
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			if (s%2 != confines.rightedge%2) {
				knit("+", "b", s, carrier);
			}
		}
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			if (s%2 != confines.rightedge%2) {
				knit("-", "f", s, carrier);
			}
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			if (s%2 == confines.rightedge%2) {
				knit("+", "b", s, carrier);
			}
		}
	}
	else if (style == "allneedle") {
		align(-1);
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			knit("-", "f", s, carrier);
			knit("-", "b", s, carrier);
		}
		align(0);
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			knit("+", "f", s, carrier);
			knit("+", "b", s, carrier);
		}
	}
	else if (style == "tuck") {
		k.stitchNumber(94);
		var bed = confines.side;
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			if (Math.abs(s%2) == Math.abs(confines.rightedge%2)) {
				knit("-", bed, s, carrier);
			}
		}
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			if (Math.abs(s%2) != Math.abs(confines.rightedge%2)) {
				knit("+", bed, s, carrier);
			}
		}
		k.stitchNumber(95);
	}
	if (carriers["hook"]) {
		releaseHook(carrier);
	}
}

function triangleShortRows (bed, confines, carrier, setback) {
	if (typeof setback == "undefined") setback = 1;
	// shortrow a nice round fingertip
	for (var s = confines.rightedge; s>confines.leftedge+((((confines.rightedge - confines.leftedge)/(2*setback))-1)*setback); s--) {
		knit("-", bed, s, carrier);
	}
	for (var i = Math.round((confines.rightedge - confines.leftedge)/(2*setback)); i>0; i--) {
		for (var s = Math.round(confines.rightedge - (i*setback) - 1); s>confines.leftedge+((i-1)*setback); s--) {
			knit("-", bed, s, carrier);
		}
		tuck("+", bed, Math.round(confines.leftedge+((i-1)*setback)), carrier);
		for (var s = Math.round(confines.leftedge+((i-1)*setback) + 1); s <= confines.rightedge - ((i)*setback); s++) {
			knit("+", bed, s, carrier);
		}
		if (i>1) tuck("-", bed, Math.round(confines.rightedge - ((i - 1)*setback)), carrier);
		else {
			for (var s = Math.round(confines.rightedge - ((i - 1)*setback)); s<=confines.rightedge; s++) {
				knit("+", bed, s, carrier);
			}
		}
	}
}

function fingertip (confines, carrier, setback) {
	if (typeof setback == "undefined") setback = 1;
	triangleShortRows("f", confines, carrier, setback);
	triangleShortRows("b", confines, carrier, setback);
}

function bindoff (style, confines, carrier) {
	if (style == "closed") {
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			knit("-", "b", s, carrier);
			xfer("b", s, "f", s);
			knit("-", "f", s, carrier);
			if (s != confines.leftedge) xfer("f", s, "b", s - 1, "centered");
		}
		align("centered");
		var tag = makeTag(confines.leftedge, carrier);
		yarnOut(carrier);
		dropAll(tag);
	}
	else if (style == "stretchy") {
		k.stitchNumber(93);
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			knit("-", "f", s, carrier);
		}
		k.stitchNumber(94);
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			knit("+", "f", s, carrier);
			tuck("+", "b", s, carrier);
			xfer("f", s, "bs", s);
			xfer("bs", s, "f", s+1);
			align("centered");
		}
		align("centered");
		k.stitchNumber(95);
		var tag = makeTag(confines.rightedge+1, carrier);
		yarnOut(carrier);
		// dropAll(tag);
		for (var s=confines.leftedge; s<=confines.rightedge; s++) {
			drop("bs", s);
		}
		for (var s=tag.leftedge; s<=tag.rightedge; s++) {
			drop("f", s);
		}
	}
	else {
		yarnOut(carrier);
		dropAll(confines);
	}
}

function makeTag (s, carrier) {
	knit("+", "f", s, carrier);
	knit("-", "f", s, carrier);
	knit("+", "f", s, carrier);
	knit("-", "f", s+1, carrier);
	knit("-", "f", s, carrier);
	knit("+", "f", s, carrier);
	knit("+", "f", s+1, carrier);
	for (var i=0; i<3; i++) {
		knit("-", "f", s+2, carrier);
		knit("-", "f", s+1, carrier);
		knit("-", "f", s, carrier);
		knit("+", "f", s, carrier);
		knit("+", "f", s+1, carrier);
		knit("+", "f", s+2, carrier);
	}
	return {leftedge: s, rightedge: s+2};
}


function splitRow (confines, side, ribFunction) {
	var otherSide = (side == "f") ? "bs" : "fs";
	for (var s = confines.rightedge; s>=confines.leftedge; s--) {
		if (ribFunction(s)=="p") {
			xfer(side, s, otherSide, s);
		}
	}
}

function rejoinRow (confines, side, ribFunction) {
	var otherSide = (side == "f") ? "bs" : "fs";
	for (var s = confines.rightedge; s>=confines.leftedge; s--) {
		if (ribFunction(s)=="p") {
			xfer(otherSide, s, side, s);
		}
	}
}

function tuckIn (carrier, location) {
	var tempsList = [];
	yarnIn(carrier);
	tempsList = tuckAndRecord("-", "f", location+2, carrier, tempsList);
	tempsList = tuckAndRecord("-", "f", location, carrier, tempsList);
	tempsList = tuckAndRecord("+", "f", location+1, carrier, tempsList);
	knit("-", "f", location+2, carrier);
	knit("-", "f", location, carrier);
	knit("+", "f", location+1, carrier);
	releaseHook(carrier);
	return tempsList;
}

function tuckOut (carrier, location) {
	tempsList = tuckTo(carrier, "f", location, true);
	yarnOut(carrier);
	drop("f", location);
	return tempsList;
}

function tuckTo (carrier, bed, location, useTemps) {
	// if temps are requested, the destination location will be a tuck on the literal needle requested, 
	// whether that's hook or "slider", but the interim ones will be all on "sliders" and then dropped
	var lastNeedle = carriers[carrier].lastNeedle;
	var tempBed = bed;
	var tempsList = [];
	if (useTemps) tempBed = (bed == "f" || bed == "fs") ? "fs" : "bs";
	if (lastNeedle - location > 0) {
		for (var s = lastNeedle; s>location; s--) {
			if ((lastNeedle - s) % tuckDist == 0) {
				tempsList = tuckAndRecord("-", tempBed, s, carrier, tempsList);
			}
		}
		tuck("-", bed, location, carrier);
	}
	else {
		for (var s = lastNeedle; s<location; s++) {
			if ((s - lastNeedle) % tuckDist == 0) {
				tempsList = tuckAndRecord("+", tempBed, s, carrier, tempsList);
			}
		}
		tuck("+", bed, location, carrier);
	}

	// if (useTemps) dropAll(tempsList);
	return tempsList;
}


function tuckAndRecord (direction, bed, needle, carrier, tucksList) {
	tuck(direction, bed, needle, carrier);
	// console.log({bed: bed, needle: needle});
	tucksList.push({bed: bed, needle: needle});
	return tucksList;
}

function dropAll (tucksList) {
	if (tucksList.rightedge) {
		if (tucksList.side == "f" || tucksList.side == "tube" || !tucksList.side) {
			for (var i = tucksList.leftedge; i<=tucksList.rightedge; i++) {
				drop("f", i);
			}	
		}
		if (tucksList.side == "b" || tucksList.side == "tube") {
			for (var i = tucksList.leftedge; i<=tucksList.rightedge; i++) {
				drop("b", i);
			}	
		}
	}
	else {
		for (var i = 0; i<tucksList.length; i++) {
			var thisTuck = tucksList[i];
			// console.log(thisTuck.bed, thisTuck.needle);
			drop(thisTuck.bed, thisTuck.needle);
		}		
	}
	return [];
}

function moveChunk (confines, offset) {
	if (confines.side == "f" || confines.side == "tube") {
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			xfer("f", s, "bs", s);
		}
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			xfer("bs", s, "f", s+offset);
		}
	}
	if (confines.side == "b" || confines.side == "tube") {
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			xfer("b", s, "fs", s+offset);
		}
		for (var s=confines.rightedge; s>=confines.leftedge; s--) {
			xfer("fs", s+offset, "b", s+offset);
		}
	}
	align("centered");
	confines.rightedge = confines.rightedge + offset;
	confines.leftedge = confines.leftedge + offset;
	return confines;
}


// // ================================================================= 
// // ======================= ~ Low-level ~ =========================== 
// // ================================================================= 

// These functions handle half-gauge needle allocation, half-gauge racking,
// yarn in/out, and transfers at implicit rack values. 

function mapNeedle (bed, needle) {
	var mappedBed, mappedNeedle;
	if (gauge == "full") {
		mappedBed = bed;
		mappedNeedle = needle;
	}
	else if (gauge == "half") {
		mappedBed = (bed == "f" || bed == "fs") ? "f" : "b";
		mappedNeedle = (bed == "f" || bed == "bs") ? (2*needle) - 1 : 2*needle;
	}
	// console.log({bed: mappedBed, needle: mappedNeedle});
	return {bed: mappedBed, needle: mappedNeedle};
}

function knit (direction, bed, needle, carrier) {
	// console.log("knitting with", carrier);
	carriers[carrier].lastNeedle = needle;
	var mappedNeedle = mapNeedle(bed, needle);
	k.knit(direction, mappedNeedle.bed + mappedNeedle.needle, carrier);
}


function miss (direction, bed, needle, carrier) {
	carriers[carrier].lastNeedle = needle;
	var mappedNeedle = mapNeedle(bed, needle);
	k.miss(direction, mappedNeedle.bed + mappedNeedle.needle, carrier);
}

function tuck (direction, bed, needle, carrier) {
	carriers[carrier].lastNeedle = needle;
	var mappedNeedle = mapNeedle(bed, needle);
	k.tuck(direction, mappedNeedle.bed + mappedNeedle.needle, carrier);
}

function drop (bed, needle) {
	var mappedNeedle = mapNeedle(bed, needle);
	k.drop(mappedNeedle.bed + mappedNeedle.needle);
}

function amiss (bed, needle) {
	var mappedNeedle = mapNeedle(bed, needle);
	k.amiss(mappedNeedle.bed + mappedNeedle.needle);
}

function split (direction, fromBed, fromNeedle, toBed, toNeedle, carrier) {
	// console.log("knitting with", carrier);
	carriers[carrier].lastNeedle = fromNeedle;

	// duplicates the rack logic from xfer

	if (fromBed == toBed || (fromBed == "f" && toBed == "fs")|| (fromBed == "fs" && toBed == "f")|| (fromBed == "b" && toBed == "bs")|| (fromBed == "bs" && toBed == "b")) {
		console.log("cannot split to same bed! (you'll need to split there, then xfer back) attempted: ", fromBed, fromNeedle, toBed, toNeedle);
	}
	else {
		mappedFrom = mapNeedle(fromBed, fromNeedle);
		mappedTo = mapNeedle(toBed, toNeedle);
		offset = mappedTo.needle - mappedFrom.needle;
		if (fromBed == "f" || fromBed == "fs") offset = 0 - offset;
		k.rack(offset);
		k.split(direction, mappedFrom.bed+mappedFrom.needle, mappedTo.bed+mappedTo.needle, carrier);
		if (typeof returnAlignment !== 'undefined') align(returnAlignment);
	}
}

function yarnIn (carrier) {
	k.inhook(carrier);
	if (!carriers[carrier]) carriers[carrier] = {};
	carriers[carrier].in = true;
	carriers["hook"] = true;
	// console.log("yarn in: ", carrier, carriers);
}

function releaseHook (carrier) {
	k.releasehook(carrier);
	carriers["hook"] = false;
	// console.log("releaseHook");
	// if (carriers["hook"]) {
	// }
}

function yarnOut (carrier) {
	// console.log("yarn out: ", carrier, carriers);
	k.outhook(carrier);
	carriers[carrier].in = false;
}

function align (alignment) {
	if (alignment == "centered") {
		if (gauge == "full") {
			k.rack(-0.75);
		}
		else {
			k.rack(0);
		}
	}
	else if (typeof alignment == "number") {
		if (gauge == "full") {
			k.rack(alignment);
		}
		else {
			k.rack(2*alignment);
		}
	}
	else {
		console.log("unrecognized alignment style");
	}
}

function xfer (fromBed, fromNeedle, toBed, toNeedle, returnAlignment) {
	if (fromBed == "hf") fromBed = "fs";
	if (fromBed == "hb") fromBed = "bs";
	if (toBed == "hf") toBed = "fs";
	if (toBed == "hb") toBed = "bs";
	if (fromBed == toBed || (fromBed == "f" && toBed == "fs")|| (fromBed == "fs" && toBed == "f")|| (fromBed == "b" && toBed == "bs")|| (fromBed == "bs" && toBed == "b")) {
		console.log("cannot xfer to same bed! attempted: ", fromBed, fromNeedle, toBed, toNeedle);
	}
	else {
		mappedFrom = mapNeedle(fromBed, fromNeedle);
		mappedTo = mapNeedle(toBed, toNeedle);
		offset = mappedTo.needle - mappedFrom.needle;
		if (fromBed == "f" || fromBed == "fs") offset = 0 - offset;
		k.rack(offset);
		k.xfer(mappedFrom.bed+mappedFrom.needle, mappedTo.bed+mappedTo.needle);
		if (typeof returnAlignment !== 'undefined') align(returnAlignment);
	}
}
