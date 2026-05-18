#!/bin/bash
# Build script for Make a proper flappy bird game with very good rand
# Run this after cloning to generate code and build

set -e

echo "📦 Getting dependencies..."
flutter pub get

echo "🔨 Running build_runner..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ Build complete! Run with: flutter run"
