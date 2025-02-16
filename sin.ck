@import "PlinkyRev"

// patch
SinOsc s_l(80) => ADSR adsr_l ;
SinOsc s_r(120) => ADSR adsr_r;

// initializing reverb with wet/dry mix
PlinkyRev r(0.8) => dac;
adsr_l => r.left;
adsr_r => r.right;

0.99 => r.shim;

0.2 => r.wobble;

0.1 => r.shim;

// Blit s => dac;
.5 => s_l.gain => s_r.gain;
// .05 => r.mix;

500::ms => now;

spork~ driveL();
spork~ driveR();
spork~ driveShim();

eon => now;

fun driveL() {
  while(true) {
    adsr_l.keyOn();

    4::second => now;

    50::ms => adsr_l.attackTime;

    adsr_l.keyOff();
    adsr_l.releaseTime() => now;
    300::ms => now;
  }
}

fun driveR() {
  200::ms => now;
  while(true) {
    adsr_r.keyOn();

    4::second => now;

    50::ms => adsr_r.attackTime;

    adsr_r.keyOff();
    adsr_r.releaseTime() => now;
    450::ms => now;
  }
}

fun driveShim() {
    0.01 => float adj;
    1 => float dir;
    while(true) {
      if (r.shim() < 0.1) {
        0.11 => r.shim;
	1 => dir;
      }
      if (r.shim() > 0.99) {
        0.98 => r.shim;
	-1 => dir;
      }
      r.shim() + (dir * adj) => r.shim;

      200::ms => now;
    }
}