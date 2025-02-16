@import "Chumpinate"
@import "PlinkyRev"

// Our package version
PlinkyRev.version() => string version;

<<< "Generating PlinkyRev package version " >>>;

// instantiate a PlinkyRev package
Package pkg("PlinkyRev");

// Add our metadata...
"Nick Shaheed" => pkg.authors;

"https://github.com/nshaheed/PlinkyRev-chugin/" => pkg.homepage;
"https://github.com/nshaheed/PlinkyRev-chugin/" => pkg.repository;

"MIT" => pkg.license;
"This stereo reverb is a port of the Plinky synth's reverb (https://plinkysynth.com/)" => pkg.description;

["Effect", "Reverb", "UGen", "Plinky"] => pkg.keywords;

// generate a package-definition.json
// This will be stored in "PlinkyRev/package.json"
"./" => pkg.generatePackageDefinition;

<<< "Defining version " + version >>>;;

// Now we need to define a specific PackageVersion for test-pkg
PackageVersion ver("PlinkyRev", version);

"10.2" => ver.apiVersion;

"1.5.4.0" => ver.languageVersionMin;

"mac" => ver.os;
"universal" => ver.arch;

// The chugin file
ver.addFile("./PlinkyRev.chug");

// These build files are examples as well
ver.addExampleFile("blit.ck");
ver.addExampleFile("sin.ck");
ver.addExampleFile("help.ck");

// The version path
"chugins/PlinkyRev/" + ver.version() + "/" + ver.os() + "/PlinkyRev.zip" => string path;

<<< path >>>;

// wrap up all our files into a zip file, and tell Chumpinate what URL
// this zip file will be located at.
ver.generateVersion("./", "PlinkyRev_mac", "https://ccrma.stanford.edu/~nshaheed/" + path);

chout <= "After notarizing, use the following commands to upload the package to CCRMA's servers:" <= IO.newline();
chout <= "ssh nshaheed@ccrma-gate.stanford.edu \"mkdir -p ~/Library/Web/chugins/PlinkyRev/"
      <= ver.version() <= "/" <= ver.os() <= "\"" <= IO.newline();
chout <= "scp PlinkyRev_mac.zip nshaheed@ccrma-gate.stanford.edu:~/Library/Web/" <= path <= IO.newline();

// Generate a version definition json file, stores this in "chumpinate/<VerNo>/PlinkyRev_mac.json"
ver.generateVersionDefinition("PlinkyRev_mac", "./" );