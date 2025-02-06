#!/bin/bash

g_exist(){
    if grep -q "^$1:" /etc/group; then
        return 0
    else
        return 1
    fi
}

user_exist(){
    local username="$1"
    if grep -q "^$username:" /etc/passwd; then
        return 0
    else
        return 1
    fi
}

create_g(){
    local gname="$1"
    if g_exist "$gname"; then
        echo "Group '$gname' already exist"
        exit 1
    fi
    groupadd "$gname"
    echo "Group '$gname' created"
}

create_user(){
    local username="$1"
    local gname="$2"
    if user_exist "$username"; then
        echo "Name '$username' is already exist"
        exit 1
    fi
    useradd -g "$gname" "$username"
    echo "User '$username' created"
}

set_passwd(){
    local username="$1"
    passwd "$username"
    echo "Password set for user '$username'"
}

make_userDir(){
    local username="$1"
    local gname="$2"
    local dir="/$username"
    mkdir "$dir"
    chown "$username:$gname" "$dir"
    chmod 770 "$dir"
    chmod +t "$dir"
    echo "Dir '$dir' have been created for user '$username'"
}

myuid=$(id -u)
if [ "$myuid" -ne 0 ]; then
 echo "Root is required"
 exit 1
fi

read -p "Enter a new group name: " gname
create_g "$gname"
read -p "Enter a new username: " username
create_user "$username" "$gname"
set_passwd "$username"
make_userDir "$username" "$gname"
echo "Task completed"