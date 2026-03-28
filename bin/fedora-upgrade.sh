#!/bin/bash
set -e

# Fedora System Upgrade & Cleanup Script
# Usage: 
#   ./fedora-upgrade.sh <version>  - Prepare for upgrade (Step 1-3)
#   ./fedora-upgrade.sh cleanup    - Run post-upgrade cleanup (Step 4)

MODE=$1

if [ -z "$MODE" ]; then
    echo "Usage:"
    echo "  $0 <version>  - e.g., $0 41 (Prepare for upgrade)"
    echo "  $0 cleanup     - Run post-upgrade cleanup"
    exit 1
fi

if [ "$MODE" == "cleanup" ]; then
    echo "--- Step 4: Post-Upgrade Cleanup ---"
    
    echo ">> Installing and running rpmconf (Interactive: handles .rpmnew/.rpmsave files)..."
    sudo dnf install rpmconf -y
    sudo rpmconf -a

    echo ">> Removing unused dependencies (autoremove)..."
    sudo dnf autoremove -y

    echo ">> Cleaning up system-upgrade and DNF cache..."
    sudo dnf system-upgrade clean
    sudo dnf clean all

    echo ">> Checking for broken/duplicate packages..."
    # Check if we are using DNF5 or DNF4
    if dnf --version | grep -q "dnf5"; then
        echo "Detected DNF5 - running checks..."
        echo "System check (unsatisfied dependencies, conflicts):"
        sudo dnf check
        echo "Duplicate packages (should be empty):"
        sudo dnf repoquery --duplicates
    else
        echo "Detected DNF4 - running checks..."
        echo "Unsatisfied dependencies (should be empty):"
        sudo dnf repoquery --unsatisfied
        echo "Duplicate packages (should be empty):"
        sudo dnf repoquery --duplicated
    fi

    echo "--- Cleanup Complete ---"

    echo ""
    echo ">> (Optional) SELinux Relabeling"
    echo "If you experience permission issues or application crashes after the upgrade,"
    echo "it is recommended to relabel your filesystem's security contexts."
    echo "This process will run on the next boot."
    read -p "Do you want to schedule an SELinux relabel on the next boot? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo fixfiles -B onboot
        echo "SELinux relabel scheduled for next boot."
        read -p "Do you want to reboot now? (y/N) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Rebooting..."
            sudo reboot
        else
            echo "Please remember to reboot manually later."
        fi
    fi

    exit 0
fi

# If MODE is not "cleanup", assume it is the target version
TARGET_VERSION=$MODE

echo "--- Step 1: Updating current system ---"
sudo dnf upgrade --refresh -y

echo "--- Step 2: Installing system upgrade plugin ---"
sudo dnf install dnf-plugin-system-upgrade -y

echo "--- Step 3: Downloading Fedora $TARGET_VERSION packages ---"
sudo dnf system-upgrade download --releasever=$TARGET_VERSION -y

echo "--- Ready to Upgrade ---"
echo "The download is complete. To perform the actual upgrade and reboot, run:"
echo "sudo dnf system-upgrade reboot"
echo ""
echo "After the system reboots and the upgrade finishes, run this script again with:"
echo "$0 cleanup"
