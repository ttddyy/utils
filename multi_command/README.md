About
-----

execute given command(s) in predefined multiple directories.

* _multi_command.sh_ (mc)


Example:

    > mc ls -al                      # call "ls -al" on default directories
    > mc -g projA svn up             # call "svn up" on projA group directories
    > mc -g projA -e "mvn install"   # use -e to specify command
    > mc -g projA -c ~/.mc_groups du -sh  # use config file specified by -c 

Usage
-----

_mc_ [-lq] [-g group] [-c config] [-e command] [command]
 

Options
-------

**-l** : list directory groups

**-q** : quiet mode(no output from this script)

**-s** : stop on error

**-q** _group_name_ : specify directory group. (default group is used as default)

**-c** _config_file_ : specify config file. (default is \"~/.mc_groups\")

**-e** _command_ : specify command to run, otherwise given argument is used.


Config
------

define directory groups. (default file: "~/.mc_groups")

### Format:

shell script format. This file will be sourced.

_variable_=_dir1_,_dir2_,_dir3_  (comma delimited directories)

Sample:

    BASE=~/workspace
    projA=$BASE/sub-projA-1,$BASE/sub-projA-2,$BASE/sub-projA-3
    projB=$BASE/sub-projB-1,$BASE/sub-projB-2
    proj-all=$projA,$projB
    default=$proj-all

