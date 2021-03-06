complete -xc platformio -n '__fish_use_subcommand' -a '(for line in (echo " \
   boards    Pre-configured Embedded Boards
   ci        Continuous Integration
   device    Monitor device or list existing
   init      Initialize PlatformIO project or update existing
   lib       Library Manager
   platform  Platform Manager
   run       Process project environments
   settings  Manage PlatformIO settings
   test      Unit Testing
   update    Update installed Platforms, Packages and Libraries
   upgrade   Upgrade PlatformIO to the latest version"); set -l split (string split "  " (string trim $line)); echo -s $split[1] \t $split[-1]; end)'
