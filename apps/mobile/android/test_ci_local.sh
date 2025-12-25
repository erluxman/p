#!/bin/bash
# Local script to simulate GitHub Actions CI workflow for Android

set -e  # Exit on error

echo "=========================================="
echo "Android CI - Local Test Run"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Step 1: Run unit tests
echo -e "${BLUE}Step 1: Running unit tests...${NC}"
./gradlew test --console=plain
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Unit tests passed${NC}"
else
    echo "✗ Unit tests failed"
    exit 1
fi
echo ""

# Step 2: Build debug APK
echo -e "${BLUE}Step 2: Building debug APK...${NC}"
./gradlew assembleDebug --console=plain
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Debug APK built successfully${NC}"
    ls -lh app/build/outputs/apk/debug/app-debug.apk
else
    echo "✗ Debug APK build failed"
    exit 1
fi
echo ""

# Step 3: Build release APK
echo -e "${BLUE}Step 3: Building release APK...${NC}"
./gradlew assembleRelease --console=plain
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Release APK built successfully${NC}"
    find app/build/outputs/apk/release -name "*.apk" -exec ls -lh {} \;
else
    echo "✗ Release APK build failed"
    exit 1
fi
echo ""

# Step 4: Check for connected device/emulator
echo -e "${BLUE}Step 4: Checking for connected device/emulator...${NC}"
if adb devices | grep -q "device$"; then
    echo -e "${GREEN}✓ Device/emulator found${NC}"
    echo ""
    
    # Step 5: Run instrumented tests
    echo -e "${BLUE}Step 5: Running instrumented tests...${NC}"
    ./gradlew connectedDebugAndroidTest --console=plain
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Instrumented tests passed${NC}"
    else
        echo "✗ Instrumented tests failed"
        exit 1
    fi
else
    echo "⚠ No device/emulator connected - skipping instrumented tests"
fi
echo ""

# Step 6: Summary
echo "=========================================="
echo -e "${GREEN}All CI steps completed successfully!${NC}"
echo "=========================================="
echo ""
echo "Test results:"
echo "  - Unit tests: $(find app/build/test-results -name "*.xml" 2>/dev/null | wc -l | tr -d ' ') test result files"
echo ""
echo "APK artifacts:"
find app/build/outputs/apk -name "*.apk" 2>/dev/null | while read apk; do
    echo "  - $(basename $apk): $(du -h $apk | cut -f1)"
done

