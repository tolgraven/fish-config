function osx_settings_fixer
	read_yesno "OI you proper running this or you just gonna edit?"
    or return
    sudo xcode-select --install ^&-
    or /usr/bin/ruby -e "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" #brew
    brew tap caskroom/cask ^&-

    defaults write -g AppleInterfaceStyle -string "Dark"
    defaults write -g AppleInterfaceTheme -string "Dark"
    defaults write -g AppleLocale -string "en_SE"
    defaults write -g AppleHighlightColor -string "1.000000 0.874510 0.701961"
    defaults write -g NSFontPanelSizeSliderParams -string "2 8 24"

    defaults write -g NSUserKeyEquivalents -array 'Emoji & Symbols' '@~^$\\U00e4' 'Mirror Displays' '@~^$\\U00a8' #cant be remapped without being explicit, get them out the way

    #defaults write "com.apple.appstore" ShowDebugMenu -bool true #show debug menu
    #xcrun simctl delete unavailable #remove unavailable xcode simulators
    defaults write "com.apple.TextEdit" RichText -int 0 #textedit plain text
    defaults write -g NSTextKillRingSize -int 100 #makes yankPop: work in cocoa keybindings?

    sudo defaults write "/System/Library/Launch Daemons/com.apple.backupd-auto" StartInterval -int 1800 #change time machine backup interval to 30 min
    defaults write "com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool true #prevent time machine from prompting
    defaults write "com.apple.frameworks.diskimages" skip-verify -bool true #disable disk image verification
    defaults write "com.apple.frameworks.diskimages" skip-verify-locked -bool true
    defaults write "com.apple.frameworks.diskimages" skip-verify-remote -bool true

    defaults write "com.apple.dock" scroll-to-open -bool true #scroll gestures on dock items
    defaults write "com.apple.dock" orientation -string "right"

    chflags nohidden ~/Library #unhide user library
    defaults write "com.apple.finder" _FXShowPosixPathInTitle -bool true #show full path in finder title
    defaults write "com.apple.finder" ShowPathbar -bool true #show path bar
    defaults write "com.apple.finder" ShowStatusBar -bool true #show status bar
    defaults write "com.apple.finder" QuitMenuItem -bool true #enables quitting finder
    #defaults write "com.apple.finder" AppleShowAllFiles true #show hidden
    defaults write "com.apple.finder" FXDefaultSearchScope -string "SCcf" #curr folder as default search scope
    defaults write "com.apple.finder" FXPreferredViewStyle Nlsv #always list view
    defaults write -g AppleShowAllExtensions -bool true #show extensions
    defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false #save to disk by default, not icloud
    defaults write -g NSNavPanelExpandedStateForSaveMode -bool true #expanded save panel
    defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
    #defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true #no metadata on usb vol need exceptions
    defaults write "com.apple.screencapture" location ~/Downloads #save screenshots to downloads
    defaults write -g ApplePressAndHoldEnabled -bool false #enable key repeat (disable ios-style press-and-hold bs)

    if read_yesno "desktop?"
        eval "sudo pmset -a hibernatemode 0; sudo rm /var/vm/sleepimage; sudo touch /var/vm/sleepimage; sudo chflags uchg /var/vm/sleepimage" #clear out sleepimage to save space (if lots ram)
        sudo systemsetup -setcomputersleep Never #never sleep
        sudo systemsetup -setrestartfreeze on #autorestart on system freeze
        sudo trimforce enable #enable trim on unsupported
        defaults write "com.apple.NetworkBrowser" BrowseAllInterfaces -bool true #airdrop on any if

        #possibly turn on local backups (realtime snapshots) and/or move local .MobileBackups dir from main ssd. but then dont really want it trashing things constantly writing everything to a regular shitty hdd either with io hmm. will do once get an extra non-m2 ssd...
        #tmutil enablelocal; sleep 30; tmutil snapshot; rsync -ahvHE /.MobileBackups /Volumes/THEEXTERNALVOLUME/; rm -rf /.MobileBackups; ln -s /Volumes/THEEXTERNAL/.MobileBackups /.MobileBackups; tmutil snapshot
    end
    sudo nvram SystemAudioVolume=" " #kill boot chime
    sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist #enable ssh
    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist #enable locate/build db
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist #get itunes off my media keys?
    defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu", "/System/Library/CoreServices/Menu Extras/TimeMachine.menu", "/System/Library/CoreServices/Menu Extras/Volume.menu"

    killall Dock
end
