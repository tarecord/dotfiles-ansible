#!/bin/sh

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
