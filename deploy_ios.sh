{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
set -e\
\
BUMP_TYPE=$\{1:-patch\}\
PUBSPEC="pubspec.yaml"\
\
echo "\uc0\u55357 \u56960  Starting Flutter iOS release ($BUMP_TYPE bump)..."\
\
# Read current version\
VERSION_LINE=$(grep "^version:" "$PUBSPEC")\
CURRENT_VERSION=$(echo "$VERSION_LINE" | awk '\{print $2\}')\
\
VERSION_NAME="$\{CURRENT_VERSION%%+*\}"\
BUILD_NUMBER="$\{CURRENT_VERSION##*+\}"\
\
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION_NAME"\
\
# Increment build number always\
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))\
\
case "$BUMP_TYPE" in\
  major)\
    MAJOR=$((MAJOR + 1))\
    MINOR=0\
    PATCH=0\
    ;;\
  minor)\
    MINOR=$((MINOR + 1))\
    PATCH=0\
    ;;\
  patch)\
    PATCH=$((PATCH + 1))\
    ;;\
  *)\
    echo "\uc0\u10060  Invalid bump type: $BUMP_TYPE"\
    echo "Use: major | minor | patch"\
    exit 1\
    ;;\
esac\
\
NEW_VERSION_NAME="$MAJOR.$MINOR.$PATCH"\
NEW_VERSION="$NEW_VERSION_NAME+$NEW_BUILD_NUMBER"\
\
echo "\uc0\u55357 \u56550  Version bump:"\
echo "   $CURRENT_VERSION \uc0\u8594  $NEW_VERSION"\
\
# Update pubspec.yaml (macOS sed)\
sed -i '' "s/^version:.*/version: $NEW_VERSION/" "$PUBSPEC"\
\
# Fetch dependencies\
flutter pub get\
\
# Build IPA\
echo "\uc0\u55357 \u57056 \u65039  Building IPA..."\
flutter build ipa --release\
\
IPA_DIR="build/ios/ipa"\
IPA_FILE=$(ls "$IPA_DIR"/*.ipa | head -n 1)\
\
if [[ ! -f "$IPA_FILE" ]]; then\
  echo "\uc0\u10060  IPA not found in $IPA_DIR"\
  exit 1\
fi\
\
# Upload to App Store Connect\
echo "\uc0\u55357 \u56548  Uploading to App Store Connect..."\
fastlane pilot upload \\\
  --ipa "$IPA_FILE" \\\
  --skip_waiting_for_build_processing true\
\
echo "\uc0\u9989  Upload complete: $NEW_VERSION \u55356 \u57225 "\
}