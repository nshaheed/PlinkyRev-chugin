@import "PlinkyRev"

// patch
SinOsc s(33) => PlinkyRev r => dac;
// Blit s => dac;
.5 => s.gain;
// .05 => r.mix;

eon => now;