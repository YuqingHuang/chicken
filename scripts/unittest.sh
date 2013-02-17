#!/bin/sh

cd TCMobileServicesNetworkKit

documents_folder="$HOME""/Library/Application Support/iPhone Simulator/Documents"
if [ ! -d "$documents_folder" ]; then
	echo "Create Documents folder for test..."
	mkdir -v "$documents_folder"
fi

xcodebuild -sdk iphonesimulator -configuration SQI -target TCMobileServicesNetworkKitTests clean build TEST_AFTER_BUILD=YES

if [ -d "$documents_folder" ]; then
	echo "Remove the Documents folder..."
	rm -rvf "$documents_folder"
fi

cd ..