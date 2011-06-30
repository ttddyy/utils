#! /bin/sh
#
#  Multi Directory Command (mc)
#    execute given command(s) to multiple predefined directories. 
#    
#  config file: (default is "~/.mc_groups")
#    format) shell script format. (this file will be sourced) 
#       variable="comma delimited directories"
#    sample)
#       BASE=~/workspace
#       projA=$BASE/sub-projA-1,$BASE/sub-projA-2,$BASE/sub-projA-3
#       projB=$BASE/sub-projB-1,$BASE/sub-projB-2
#       proj-all=$projA,$projB
#       default=$proj-all
#
#  example)
#    > mc ls -al
#    > mc -g projA ls -al
#    > mc -g projA -e "ls -al"
#    > mc -g projA -c ~/.mc_groups ls -al
#  

usage() {
  echo "Usage: ";
  echo "  $0 [-lq] [-g group] [-c config] [-e command] [command] ";
  echo "Options: ";
  echo "  -l : list directory groups";
  echo "  -q : quiet mode(no output from this script)";
  echo "  -s : stop on error";
  echo "  -q group_name : specify directory group";
  echo "  -c config_file : specify config file. (default is \"~/.mc_groups\")";
  echo "  -e command : specify command to run, otherwise given argument is used";
}

LIST_GROUPS=0;
QUIET_MODE=0;
STOP_ON_ERROR=0;
GROUP="default";
CONFIG=~/.mc_groups;   # default config file location
COMMAND="";

while getopts "lqsg:c:e:" OPT; do
  case $OPT in 
    "l" ) LIST_GROUPS=1;;   # list groups
    "q" ) QUIET_MODE=1;;        # quiet mode
    "s" ) STOP_ON_ERROR=1;;     # stop if command finished with error
    "g" ) GROUP=$OPTARG;;   # specify group
    "c" ) CONFIG=$OPTARG;;  # specify config file
    "e" ) COMMAND=$OPTARG;; # specify commands
    \?  ) usage; exit 1;;
  esac
done
shift $(($OPTIND - 1))

# stop further processing on error if specified
if (($STOP_ON_ERROR)); then
  set -e;
fi

# check the config file
if [ ! -e $CONFIG ]; then
  echo "${CONFIG} file doesn't exist.";
  exit 1;
fi

# load config file
if ((!$QUIET_MODE)); then
  echo "config file: ${CONFIG}";
fi
source $CONFIG;

# list groups
if (($LIST_GROUPS)); then
  echo "available groups:";
  cat $CONFIG | grep = | cut -f1 -d= | sed -e 's/^/ - /';
  exit 0;
fi

# define commands to execute 
if [ -z "${COMMAND}" ]; then
  COMMAND=$*;
fi
if ((!$QUIET_MODE)); then
  echo "command: $COMMAND";
fi

# execute commands
if ((!$QUIET_MODE)); then
  echo "group: $GROUP";
fi
for DIR in `eval echo '$'$GROUP | sed -e 's/,/ /g'`; do
  if ((!$QUIET_MODE)); then
    echo "dir: $DIR";
  fi
  cd $DIR;
  $COMMAND;
done

exit 0;
