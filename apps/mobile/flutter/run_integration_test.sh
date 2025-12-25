#!/bin/bash
# Script to run integration tests on iOS device
# Usage: ./run_integration_test_ios.sh [device-id]
# Example: ./run_integration_test_ios.sh 00008030-001A4D1E12345678

DEVICE_ID=${1}

echo "Running integration tests on iOS device: $DEVICE_ID"
flutter drive \
  --driver=test/integration/infra/driver.dart \
  --target=test/integration/todo_feature_integration_test.dart \
  --device-id=$DEVICE_ID

