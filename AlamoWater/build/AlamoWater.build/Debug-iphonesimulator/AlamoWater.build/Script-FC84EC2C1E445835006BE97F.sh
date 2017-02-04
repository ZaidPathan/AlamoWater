#!/bin/sh
#!/bin/sh




UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal




# make sure the output directory exists

mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"




# Step 1. Build Device and Simulator versions

xcodebuild -target “${AlamoWater}” ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

xcodebuild -target "${AlamoWater}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build




# Step 2. Copy the framework structure (from iphoneos build) to the universal folder

cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${AlamoWater}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"




# Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory

SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${AlamoWater}.framework/Modules/${AlamoWater}.swiftmodule/."

if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then

cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/${AlamoWater}.framework/Modules/${AlamoWater}.swiftmodule"

fi




# Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory

lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${AlamoWater}.framework/${AlamoWater}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${AlamoWater}.framework/${AlamoWater}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${AlamoWater}.framework/${AlamoWater}"




# Step 5. Convenience step to copy the framework to the project's directory

cp -R "${UNIVERSAL_OUTPUTFOLDER}/${AlamoWater}.framework" "${PROJECT_DIR}"




# Step 6. Convenience step to open the project's directory in Finder

open "${PROJECT_DIR}"
