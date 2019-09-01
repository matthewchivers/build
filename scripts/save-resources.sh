#!/bin/sh

set -e

echo "Saving docker images"
docker save galasa/galasa-resources-amd64:0.3.0 | gzip > galasa-resources.tar.gz

echo "Save complete"

