#!/bin/sh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# set reasonable macOS defaults
# inspired by : https://github.com/mathiasbynens/dotfiles
# more can be found here : https://gist.github.com/brandonb927/3195465

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

set +e

echo "  › Use AirDrop over every interface. srsly this should be a default."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

echo "  › show the ~/Library folder"
chflags nohidden ~/Library

echo "  › disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Autohide Dock"
defaults write com.apple.dock autohide -bool true

echo "  › Customize Dock Icon Size"
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 50

echo "  › Disable Recents in Dock"
defaults write com.apple.dock show-recents -bool false && killall Dock

echo "  › Wipe all (default) app icons from the Dock (y/n)"
echo "(This is only really useful when setting up a new Mac, or if you don't use the Dock to launch apps.)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.dock persistent-apps -array
fi

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
