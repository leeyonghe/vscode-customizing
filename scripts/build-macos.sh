#!/bin/bash

# VS Code macOS Build Script
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Print with color
print() {
	echo -e "${2}${1}${NC}"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
	print "This script can only be run on macOS" "$RED"
	exit 1
fi

# Check for required dependencies
print "Checking dependencies..." "$YELLOW"

# Check for Node.js
if ! command -v node &> /dev/null; then
	print "Node.js is not installed. Please install Node.js first." "$RED"
	exit 1
fi

# Check for npm
if ! command -v npm &> /dev/null; then
	print "npm is not installed. Please install npm first." "$RED"
	exit 1
fi

# Check for Git
if ! command -v git &> /dev/null; then
	print "Git is not installed. Please install Git first." "$RED"
	exit 1
fi

# Set Node.js memory limit
export NODE_OPTIONS="--max-old-space-size=8192"

# Install dependencies
print "Installing dependencies..." "$YELLOW"
npm install

# Build VS Code
print "Building VS Code..." "$YELLOW"
npm run compile

# Package for macOS
print "Packaging for macOS..." "$YELLOW"
npm run package -- --platform darwin

print "Build completed successfully!" "$GREEN"
