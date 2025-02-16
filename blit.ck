@import "PlinkyRev"

// patch
Blit s => Pan2 p => PlinkyRev r(0.65) => dac;
// Blit s => dac;
.5 => s.gain;

// an array
[ 0, 2, 4, 7, 9, 11 ] @=> int hi[];
// <<< hi.size() >>>;
// <<< hi[0], hi[1], hi[2], hi[3], hi[4], hi[5] >>>;

// infinite time loop
while( true )
{
    // frequency
    Std.mtof( 33 + Math.random2(0,3) * 12 +
        hi[Math.random2(0,hi.size()-1)] ) => s.freq;

    // harmonics
    Math.random2( 1, 5 ) => s.harmonics;

    Math.random2f(-0.5, 0.5) => p.pan;

    // advance time
    120::ms => now;
}
