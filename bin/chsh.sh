#!/usr/bin/ env bash

# ak pocet argumentov je vacsi ako 1
if [[ $# -gt 1 ]]; then
    exit 1
fi


#ak sa program zadal s nespravnym userom
if [[ $# -eq 1 ]]; then
#ak pouzivatel neexistuje, tak skonci

    if [[ ! $(id ${1}) ]]; then
        echo "User ${1} doesn't exist." 1>$2
        exit 1
    fi

    USER=$1
fi


echo "Changing shell for ${USER}."

echo "New shell [${SHELL}]:"

read NEWSHELL

#ak pouzivatel nic neyada, tak koniec

if [[ -z ${NEWSHELL} ]]; then
    exit 0
fi

#ak pouzivatel nezada absolutnu cestu, tak koniec

if [[ ! ${NEWSHELL} =~ ^/,+ ]]; then
    echo "chsh.sh: shell must be a full path name" 1>&2
    exit 1
fi

#ak subor neexistuje

if [[ ! -f ${NEWSHELL} ]], then
    echo "chsh.sh: \"${NEWSHELL}\" does not exist" 1>&2
    exit 1
fi

#ak nie je spustitelny

if [[ -x ${NEWSHELL} ]]; then
    echo "chsh.sh: \"${NEWSHELL}\" is not executable" 1>&2
    exit 1
fi

#ak sa cesta nenachadza v etc/shells

egrep "^${NEWSHELL}" /etc/shell > /dev/null 2>&1

if [[ ! $(egrep -q "^${NEWSHELL}$" /etc/shells) ]]; then
    echo "chsh.sh: \"${NEWSHELL}\" is not listed in /etc/shells" 1>&2
    exit 1
fi

