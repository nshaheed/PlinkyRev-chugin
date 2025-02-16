#--------------------------------------------------------------
# codesign.sh
# pre-condition: both arm64 and intel PlinkyRev.chug builds
#  are located in the proper directories 
#--------------------------------------------------------------

# where the PlinkyRev build can be found
PLINKYREV_UB=./PlinkyRev.chug

# remove code signature from chugin and dylibs
codesign --remove-signature ${PLINKYREV_ARM}
codesign --remove-signature ${PLINKYREV_INTEL}

# codesign PlinkyRev.chug
codesign --deep --force --verify --verbose --timestamp --options runtime --entitlements PlinkyRev.entitlements --sign "Developer ID Application" ${PLINKYREV_UB}
