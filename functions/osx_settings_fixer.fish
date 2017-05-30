function osx_settings_fixer
	read_yesno "OI you proper running this or you just meant to edit?"; or return
	read_yesno "Set hostname?"; and read -l newname; and sudo systemsetup -setcomputername "$name"
	if read_yesno "Setup brew and xcode?"
    sudo xcode-select --install ^&-; or /usr/bin/ruby -e (curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
		brew tap homebrew/services; brew tap neovim/neovim tldr-pages/tldr universal-ctags/universal-ctags
		brew cask; brew tap caskroom/fonts caskroom/versions
    sudo xcodebuild -license
	end

	echoerr "SETTINGS - UI"
		for part in Style Theme; defaults write -g AppleInterface$part -string "Dark"; end
    # defaults write -g AppleLocale -string "en_SE"; 					defaults write -g AppleMetricUnits -bool TRUE
    defaults write -g AppleHighlightColor -string "0.149 0.403 0.462" 	#bruvbox blue.   old: "1.000000 0.874510 0.701961" sommme orange bs
		pushd /System/Library/CoreServices/Spotlight.app/Contents/MacOS; sudo cp Spotlight .Spotlight.bak; sudo perl -pi -e 's|(\x00\x00\x00\x00\x00\x00\x47\x40\x00\x00\x00\x00\x00\x00)\x42\x40(\x00\x00\x80\x3f\x00\x00\x70\x42)|$1\x00\x00$2|sg' Spotlight; sudo codesign -f -s - Spotlight; sudo killall Spotlight; popd 	#patch spotlight icon to 0 width. or just pirate batender tbh.

    defaults write -g NSFontPanelSizeSliderParams -string "2 8 24"
    defaults write -g NSUserKeyEquivalents 				-array 'Emoji & Symbols' '@~^$\\U00e4' 'Mirror Displays' '@~^$\\U00a8' 	#cant be remapped without being explicit, get them out the way

	if read_yesno "Setup Dock and Finder?"
		set -l dock "scroll-to-open -bool TRUE" "orientation -string 'right'" "showhidden -bool TRUE" "expose-animation-duration -float 0.10" "autohide-delay -float 0"	scroll-to-open icons, dock on right, fade hidden apps, speed up mission control anim, instant popup if hiddden
		for opt in $dock; defaults write "com.apple.dock" $opt; end
		# rm trash from dock: add dict just after EMPTY_TRASH, integer 1004 name REMOVE_FROM_DOCK
		# /System/Library/CoreServices/Dock.app/Contents/Resources/DockMenus.plist

		set -l finder "_FXShowPosixPathInTitle -bool TRUE" "ShowPathbar -bool TRUE" "ShowStatusBar -bool TRUE" "QuitMenuItem -bool TRUE" "AppleShowAllFiles -bool TRUE" "FXDefaultSearchScope -string 'SCcf'" "FXPreferredViewStyle -string 'Nlsv'" "FXEnableExtensionChangeWarning -bool FALSE" "CreateDesktop -bool FALSE"
		for opt in $finder; defaults write "com.apple.finder" $opt; end #full path in title, pathbar, statusbar, enable quitting finder, show hidden, curr folder default search scope, list view everywhere, dont warn on ext change, hide icons from desktop
		set -l finder2 ":DesktopViewSettings:IconViewSettings:showItemInfo -bool TRUE" ":FK_StandardViewSettings:IconViewSettings:showItemInfo -bool TRUE" ":StandardViewSettings:IconViewSettings:showItemInfo -bool TRUE" "DesktopViewSettings:IconViewSettings:labelOnBottom -bool FALSE"
		for opt in $finder2; /usr/libexec/PlistBuddy -c "Set $opt" ~/Library/Preferences/com.apple.finder.plist; end

    sudo chflags nohidden ~/Library /Volumes 														#unhide user library

    defaults write -g AppleShowAllExtensions 							-bool TRUE 					#show extensions
    defaults write -g NSDocumentSaveNewDocumentsToCloud 	-bool FALSE 				#save to disk by default, not icloud
    # defaults write -g NSNavPanelExpandedStateForSaveMode 	-bool TRUE; defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool TRUE 	#expanded save panel
		for d in "" 2; defaults write -g NSNavPanelExpandedStateForSaveMode$d -bool TRUE; end
	end

    defaults write "com.apple.systemuiserver" menuExtras -array (string escape "/System/Library/CoreServices/Menu Extras/"{Bluetooth,TimeMachine,Volume}.menu)

		for opt in DiskGraphType NetworkGraphType; defaults write "com.apple.ActivityMonitor" $opt -int 1; end 		#show data instead of IO/packets

		echoerr "SETTINGS - keys/repeat, TM, disk images"
    #defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE 		#no metadata on usb vol need exceptions
    defaults write 'com.apple.screencapture' location 					~/Downloads 	#save screenshots to downloads
    defaults write 'com.apple.ImageCapture'  disableHotPlug 		-bool TRUE 					#no auto open photos app
    defaults write 'com.apple.TextEdit' 		RichText 						-int 	0 						#textedit plain text
    defaults write -g									NSTextKillRingSize 				-int 	100 					#makes yankPop: work in cocoa keybindings?
    defaults write -g									ApplePressAndHoldEnabled 	-bool FALSE 				#enable key repeat (disable iosy press&hold)
		defaults write -g									InitialKeyRepeat 					-int 	15 						#normal minimum is 15 (225 ms)
		defaults write -g									KeyRepeat 								-int 	2 						#normal minimum is 2 (30 ms)
		for opt in PeriodSubstitution QuoteSubstitution DashSubstitution Capitalization; defaults write -g NSAutomatic{$opt}Enabled -bool FALSE; end

		defaults write -g 								NSInitialToolTipDelay 		-int 	250															#global delay before tooltips appear
    defaults write 'com.apple.driver.AppleBluetoothMultitouch.mouse' 		MouseButtonMode 	TwoButton 	#enable right click
		defaults write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' Clicking 					-bool TRUE 				#enable tap to click
		defaults write 'com.apple.AppleMultitouchTrackpad' 	TrackpadTwoFingerDoubleTapGesture 0 					#smart zoom. cant have that one cause causes such a shitty delay every single right click hey. three finger double-tap for smart zoom in BTT instead...	

		defaults write -g									QLEnableTextSelection 		-bool TRUE 											#select/copy from QL
		defaults write -g									QLPanelAnimationDuration 	-float 0.1   										#quicken QL animation
		#potentially  interesting ones:
		#AppleAntiAliasThinningThreshold

    defaults write "com.apple.LaunchServices" LSQuarantine 			-bool FALSE 				#disable 'are you sure you want to open this application?'
		sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool FALSE 		#dont auto-rearm gatekeeper
		sudo spctl --master-disable 																										#enable ability to disable gatekeeper in privacy settings
    # sudo defaults write "/System/Library/Launch Daemons/com.apple.backupd-auto" StartInterval -int 1800 	#change time machine backup interval to 30 min
    defaults write "com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool TRUE 	#prevent time machine from prompting
    # defaults write "com.apple.frameworks.diskimages" skip-verify -bool TRUE; defaults write "com.apple.frameworks.diskimages" skip-verify-locked -bool TRUE; defaults write "com.apple.frameworks.diskimages" skip-verify-remote -bool TRUE
		for opt in verify verify-locked verify-remote; defaults write "com.apple.frameworks.diskimages" skip-$opt -bool TRUE; end 	#disable disk image verification
    sudo defaults write "/Library/Preferences/SystemConfiguration/autodiskmount" AutomountDisksWithoutUserLogin -bool TRUE	#automount external disks on boot instead of login (helps some issues when have symlinked stuff out)

    if read_yesno "desktop?"; echoerr "nuking sleepimage, fixing hackintosh stuffs, trim etcs"
        sudo fish -c "pmset -a hibernatemode 0; set -l img /var/vm/sleepimage; rm $img; touch $img; chflags uchg $img"		#clear out sleepimage to save space (if lots ram)
        sudo systemsetup -setcomputersleep Never -setrestartfreeze on					#never sleep, autorestart on system freeze
        sudo trimforce enable 																								#enable trim on unsupported
        defaults write "com.apple.NetworkBrowser" BrowseAllInterfaces -bool TRUE 		#airdrop on any interface
        #possibly turn on local backups (realtime snapshots) and/or move local .MobileBackups dir from main ssd. but then dont really want it trashing things constantly writing everything to a regular shitty hdd either with io hmm. will do once get an extra non-m2 ssd...
        #tmutil enablelocal; sleep 30; tmutil snapshot; rsync -ahvHE /.MobileBackups /Volumes/THEEXTERNALVOLUME/; rm -rf /.MobileBackups; ln -s /Volumes/THEEXTERNAL/.MobileBackups /.MobileBackups; tmutil snapshot
    else if read_yesno "laptop?"
				sudo firmwarepasswd -setpasswd -setmode command			 									#enable firmware password, prompt for new password, require password to boot from other volumes.

        defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1; defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    end

		echoerr "Kill chime, Load SSH, build locate db, unload crashreporter..."
    sudo nvram SystemAudioVolume=" " 														#kill boot chime
    sudo launchctl enable system/com.openssh.sshd; sudo launchctl enable system/com.apple.locate 		#enable ssh, enable locate and build db
    sudo defaults write "/System/Library/User Template/Non_localized/Library/Preferences/com.apple.SetupAssistant" DidSeeCloudSetup -bool TRUE 		#turn off post-update/loginwindow icloud setup assistant as it has fucked my shit at least once w black screen of death
		
		# launchctl unload -w /System/Library/LaunchAgents/com.apple.AddressBook.SourceSync.plist	 #seems like only solution for this cunt popping up every 30s as a new process, burning cpu... core issue seems to have gone unfixed by apple _SINCE MOBILEME DAYS_ wtffff
		sudo launchctl disable system/com.apple.AddressBook.SourceSync	 #seems like only solution for this cunt popping up every 30s as a new process, burning cpu... core issue seems to have gone unfixed by apple _SINCE MOBILEME DAYS_ wtffff
		defaults write 'com.apple.dashboard' 			mcx-disabled 			-bool TRUE 					#disable dashboard

		sudo launchctl disable system/com.apple.gamed
    sudo launchctl disable system/com.apple.rcd											#get itunes off my media keys?
		sudo launchctl disable system/com.apple.ReportCrash; sudo launchctl disable system/com.apple.ReportCrash.Root		#unload reportcrash by default since it can use bizarre resources if some launchctl-managed process repeatedly crashes. fuck you, Apple.
    #vim /System/Library/LaunchDaemons/com.apple.syslogd.plist #is binary plist so need to fiddle unless can edit in place. add <string>-mps_limit</string> \n <string>[new syslog msg-per-second limit (or 0 to disable limit]</string> below <string>/u/sbin/syslogd</string> then launchctrl unload/reload

		#vim edit that thing that sets ulimit etc...
		#
		#enable accessibility permissions for app:
		#sudo tccutil -e app.bundle.identifier

		nfsd enable; nfsd start
    # xcrun simctl delete unavailable ^&-																					#remove unavailable xcode simulators
    # defaults write "com.apple.appstore" ShowDebugMenu -bool TRUE 										#show app store debug menu
	sudo defaults write "com.apple.usbd" NoIPadNotifications -bool TRUE; sudo defaults write "com.apple.usbd" NoIPhoneNotifications -bool TRUE

	echoerr "RESTARTING PROCESSES..."
    killall Dock Finder cfprefsd 			#restart relevant processes

	echoerr "INSTALLING BASICS..."
		brew install mas python python3 node rbenv ^&-
		# mas signin
		mas install xcode; mas upgrade
		brew cask install iterm2-beta atom google-chrome spotify alfred karabiner-elements hammerspoon flux bettertouchtool ^&-
		brew cask intall font-fira-code font-firacode-nerd-font ^&-
		brew cask install betterzipql qlcolorcode qlimagesize qlmarkdown qlprettypatch qlstephen qlvideo qlswift scriptql quicklook-json epubquicklook quicklook-csv ^&-
end
