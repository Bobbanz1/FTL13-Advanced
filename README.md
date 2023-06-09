## FTL13

[![Build Status](https://travis-ci.org/FTL13/FTL13.png)](https://travis-ci.org/FTL13/FTL13)
<BR>[![Percentage of issues still open](http://isitmaintained.com/badge/open/Bobbanz1/FTL13-Advanced.svg)](http://isitmaintained.com/project/Bobbanz1/FTL13-Advanced "Percentage of issues still open") [![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/Bobbanz1/FTL13-Advanced.svg)](http://isitmaintained.com/project/Bobbanz1/FTL13-Advanced "Average time to resolve an issue")
<BR>[![forthebadge](http://forthebadge.com/images/badges/built-with-resentment.svg)](http://forthebadge.com)

**Website:** http://www.ftl13.com <BR>
**Code:** https://github.com/FTL13/FTL13 <BR>
**Wiki** http://ftl13.com/wiki/index.php/Main_Page <BR>
**Discord:** http://www.discord.me/ftl13 <BR>


## DOWNLOADING

There are a number of ways to download the source code. Some are described here, an alternative all-inclusive guide is also located at http://www.ftl13.com/wiki/index.php/Downloading_the_source_code

Option 1:
Follow this: http://www.ftl13.com/wiki/index.php/Setting_up_git

Option 2:
Install GitHub::windows from http://windows.github.com/
It handles most of the setup and configuraton of Git for you.
Then you simply search for the tgstation repository and click the big clone
button.

Option 3: Download the source code as a zip by clicking the ZIP button in the
code tab of https://github.com/FTL13/FTL13/

First-time installation should be fairly straightforward.  First, you'll need
BYOND installed.  You can get it from http://www.byond.com/.  Once you've done
that, extract the game files to wherever you want to keep them.  This is a
sourcecode-only release, so the next step is to compile the server files.
Open ftl13.dme by double-clicking it, open the Build menu, and click
compile.  This'll take a little while, and if everything's done right you'll get
a message like this:

```
saving ftl13.dmb (DEBUG mode)
ftl13.dmb - 0 errors, 0 warnings
```

If you see any errors or warnings, something has gone wrong - possibly a corrupt
download or the files extracted wrong. If problems persist, ask for assistance
in irc://irc.rizon.net/coderbus

Once that's done, open up the config folder.  You'll want to edit config.txt to
set the probabilities for different gamemodes in Secret and to set your server
location so that all your players don't get disconnected at the end of each
round.  It's recommended you don't turn on the gamemodes with probability 0,
except Extended, as they have various issues and aren't currently being tested,
so they may have unknown and bizarre bugs.  Extended is essentially no mode, and
isn't in the Secret rotation by default as it's just not very fun.

You'll also want to edit config/admins.txt to remove the default admins and add
your own.  "Game Master" is the highest level of access, and probably the one
you'll want to use for now.  You can set up your own ranks and find out more in
config/admin_ranks.txt

The format is

```
byondkey = Rank
```

where the admin rank must be properly capitalised.

This codebase also depends on a native library called rust-g. A precompiled
Windows DLL is included in this repository, but Linux users will need to build
and install it themselves. Directions can be found at the [rust-g
repo](https://github.com/tgstation13/rust-g).

Finally, to start the server, run Dream Daemon and enter the path to your
compiled ftl13.dmb file.  Make sure to set the port to the one you
specified in the config.txt, and set the Security box to 'Safe'.  Then press GO
and the server should start up and be ready to join. It is also recommended that
you set up the SQL backend (see below).

If you'd like a more robust server hosting option for tgstation and its
derivatives. Check out our server tools suite at
https://github.com/tgstation/tgstation-server

## UPDATING

To update an existing installation, first back up your /config and /data folders
as these store your server configuration, player preferences and banlist.

Then, extract the new files (preferably into a clean directory, but updating in
place should work fine), copy your /config and /data folders back into the new
install, overwriting when prompted except if we've specified otherwise, and
recompile the game.  Once you start the server up again, you should be running
the new version.

## MAPS

/tg/station currently comes equipped with three maps.

* [Aetherwhisp (default)](https://ftl13.com/wiki/index.php?title=Aetherwhisp)
* [Trailmeme](https://ftl13.com/wiki/index.php?title=Trailblazer)
* [Tuning Fork](https://ftl13.com/wiki/index.php?title=SpaceSHIP)

All maps have their own code file that is in the base of the _maps directory. Maps are loaded dynamically when the game starts. Follow this guideline when adding your own map, to your fork, for easy compatibility.

The map that will be loaded for the upcoming round is determined by reading data/next_map.json, which is a copy of the json files found in the _maps tree. If this file does not exist, the default map from config/maps.txt will be loaded. Failing that, tgstation2 will be loaded. If you want to set a specific map to load next round you can use the Change Map verb in game before restarting the server or copy a json from _maps to data/next_map.json before starting the server. Also, for debugging purposes, ticking a corresponding map's code file in Dream Maker will force that map to load every round.

If you are hosting a server, and want randomly picked maps to be played each round, you can enable map rotation in [config.txt](config/config.txt) and then set the maps to be picked in the [maps.txt](config/maps.txt) file.

Anytime you want to make changes to a map it's imperative you use the [Map Merging tools](http://ftl13.com/wiki/index.php/Map_Merger)

## AWAY MISSIONS

/tg/station supports loading away missions however they are disabled by default.

Map files for away missions are located in the _maps/RandomZLevels directory. Each away mission includes it's own code definitions located in /code/modules/awaymissions/mission_code. These files must be included and compiled with the server beforehand otherwise the server will crash upon trying to load away missions that lack their code.

To enable an away mission open `config/awaymissionconfig.txt` and uncomment one of the .dmm lines by removing the #. If more than one away mission is uncommented then the away mission loader will randomly select one the enabled ones to load.

## SQL SETUP

The SQL backend requires a MySQL server. SQL is required for the library, stats tracking, admin notes, and job-only bans, among other features, mostly related to server administration. Your server details go in /config/dbconfig.txt, and the SQL schema is in /SQL/tgstation_schema.sql and /SQL/tgstation_schema_prefix.sql depending on if you want table prefixes.  More detailed setup instructions are located here: http://www.ftl13.com/wiki/index.php/Downloading_the_source_code#Setting_up_the_database

## IRC BOT SETUP

Included in the repository is a python3 compatible IRC bot capable of relaying adminhelps to a specified
IRC channel/server, see the /bot folder for more

## CONTRIBUTING

Please see [CONTRIBUTING.md](.github/CONTRIBUTING.md)

## LICENSE

All code after commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST (https://github.com/FTL13/FTL13/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under GNU AGPL v3 (http://www.gnu.org/licenses/agpl-3.0.html).

All code before commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST (https://github.com/FTL13/FTL13/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under GNU GPL v3 (https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE-AGPLv3.txt and LICENSE-GPLv3.txt for more details.

tgui clientside is licensed as a subproject under the MIT license.
Font Awesome font files, used by tgui, are licensed under the SIL Open Font License v1.1
tgui assets are licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
The TGS3 API is licensed as a subproject under the MIT license.

See tgui/LICENSE.md for the MIT license.
See tgui/assets/fonts/SIL-OFL-1.1-LICENSE.md for the SIL Open Font License.
See the footers of code/\_\_DEFINES/server\_tools.dm, code/modules/server\_tools/st\_commands.dm, and code/modules/server\_tools/st\_inteface.dm for the MIT license.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](http://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
