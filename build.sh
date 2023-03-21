# Set image name. Default name provided.
IMAGE_NAME="ubuntu-base-arm64"

# Set tag to first provided argument, otherwise default to "latest"
if [ -z "$1" ]; then
    TAG="latest"
else
    TAG=$1
fi

# Configure console colors & timestamp
Blue='\033[0;34m'                 # Text Color Blue
color_off='\033[0m'               # End Text Coloring
INFO="[${Blue}INFO${color_off}]"  # INFO tag
TIMESTAMP="$(date '+%Y-%m-%dT%H:%M:%S %Z')"

# Script Info
echo "$INFO [$TIMESTAMP] This script was built on Ubuntu 22.04.2 LTS"
echo "$INFO [$TIMESTAMP] You are currently running: $(head -1 /etc/os-release | cut -d "\"" -f 2)"

# Log: Starting build
echo "$INFO [$TIMESTAMP] Building image: $IMAGE_NAME:$TAG"

# Build image
docker build -t $IMAGE_NAME:$TAG .

# Log: Success or failure
if [ $? -eq 0 ]; then
    echo "$INFO [$TIMESTAMP] Build complete: $IMAGE_NAME:$TAG"
else
    echo "$INFO [$TIMESTAMP] Build failed. See output for more information."
fi
