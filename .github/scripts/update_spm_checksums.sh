#!/bin/bash

# ─────────────────────────────────────────────────────────────
# update_spm_checksums.sh
#
# Zips xcframeworks, computes their SHA-256 checksums, and
# updates the checksum values in Package.swift.
#
# The developer is responsible for setting the release tag
# in the URL (replace <version> with the actual tag name).
#
# Usage (from repo root):
#   .github/scripts/update_spm_checksums.sh
# ─────────────────────────────────────────────────────────────

set -euo pipefail

PACKAGE_SWIFT="Package.swift"
CORE_DIR="Pod/core"

# ── Zip the xcframeworks ─────────────────────────────────────
echo "📦 Zipping xcframeworks..."

for framework in Razorpay RazorpayCore; do
    xcf_path="${CORE_DIR}/${framework}.xcframework"
    zip_path="${CORE_DIR}/${framework}.xcframework.zip"

    if [ ! -d "$xcf_path" ]; then
        echo "❌ Error: ${xcf_path} not found"
        exit 1
    fi

    rm -f "$zip_path"

    if command -v ditto &> /dev/null; then
        ditto -c -k --sequesterRsrc --keepParent "$xcf_path" "$zip_path"
    else
        (cd "$CORE_DIR" && zip -r -y "${framework}.xcframework.zip" "${framework}.xcframework")
    fi

    echo "  ✅ Created ${zip_path}"
done

# ── Compute checksums ────────────────────────────────────────
compute_checksum() {
    local file=$1
    if command -v swift &> /dev/null; then
        swift package compute-checksum "$file"
    elif command -v shasum &> /dev/null; then
        shasum -a 256 "$file" | awk '{print $1}'
    else
        sha256sum "$file" | awk '{print $1}'
    fi
}

RAZORPAY_CHECKSUM=$(compute_checksum "${CORE_DIR}/Razorpay.xcframework.zip")
RAZORPAYCORE_CHECKSUM=$(compute_checksum "${CORE_DIR}/RazorpayCore.xcframework.zip")

echo ""
echo "🔐 Checksums:"
echo "  Razorpay:     ${RAZORPAY_CHECKSUM}"
echo "  RazorpayCore: ${RAZORPAYCORE_CHECKSUM}"

# ── Update checksums in Package.swift ────────────────────────
echo ""
echo "📝 Updating checksums in Package.swift..."

sed -i.bak -E \
    '/name: "Razorpay"/{
        n
        n
        s|checksum: ".*"|checksum: "'"${RAZORPAY_CHECKSUM}"'"|
    }' "$PACKAGE_SWIFT"

sed -i.bak -E \
    '/name: "RazorpayCore"/{
        n
        n
        s|checksum: ".*"|checksum: "'"${RAZORPAYCORE_CHECKSUM}"'"|
    }' "$PACKAGE_SWIFT"

rm -f "${PACKAGE_SWIFT}.bak"

echo "✅ Package.swift checksums updated"
echo ""
echo "📋 Next steps:"
echo "  1. Replace <version> in Package.swift URLs with your release tag"
echo "  2. Commit Package.swift"
echo "  3. Create a GitHub Release and upload the zip files from Pod/core/"
