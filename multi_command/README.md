About
-----

### Multiple Directories Command  

execute given command(s) in predefined multiple directories.

* _multi_command.sh_ (mc)


Example:

    > mc ls -al                          # call "ls -al" on default directories(defined in config file)
    > mc -g projA git co master          # call "git co master" on projA group directories(defined in config file)
    > mc -g projA -e "mvn install"       # use -e to specify command
    > mc -g projA -c sample_config du -sh    # use config file specified by -c 

Usage
-----

    mc [-lqs] [-g group] [-c config] [-e command] [command]
 

Options
-------

**-l** : list directory groups

**-q** : quiet mode(no output from this script)

**-s** : stop on error

**-g** _group_name_ : specify directory group. ("default" group is used as default)

**-c** _config_file_ : specify config file. (default is "~/.mc_groups")

**-e** _command_ : specify command to run, otherwise given argument is used.


Config
------

define directory groups. (default file: "~/.mc_groups")

### Format:

shell script format. (This file will be sourced)

_variable_=_dir1_,_dir2_,_dir3_  (comma delimited directories)

Sample:

    BASE=~/workspace
    projA=$BASE/sub-projA-1,$BASE/sub-projA-2,$BASE/sub-projA-3
    projB="$BASE/sub-projB-1, $BASE/sub-projB-2"   # quote if space exists
    proj-all=$projA,$projB
    default=$proj-all


License
-------

Apache License 2.0

Environment
-----------

Tested on Mac 10.6
