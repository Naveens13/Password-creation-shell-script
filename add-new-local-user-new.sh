#!/bin/bash

#To check the logged in user
LOG_USER=$(id -un)
echo "Logged in user- ${LOG_USER}"

if [[ ${LOG_USER} = "root" ]]
then
  echo "User creation process started......"
else
  echo "Log in as root user."
  exit 1
fi

#To check if any arugment is passed
PAS_ARG=${#}
if [[ ${PAS_ARG} > 0 ]]
then
  echo "No. of parameters- ${#}"
else
  echo "Not passed any parameters........"
  exit 1
fi

#To take first parameter
USERNAME=${1}
FULL_NAME=${2}
echo "Username- ${USERNAME} FullName- ${FULL_NAME}"

#User creation process and checking for successful creation
useradd -c ${FULL_NAME} -m ${USERNAME}
if [[ ${?} = 0 ]]
then
 echo "User creation successful.........."
else
 echo "Error occured- ${?}"
 exit
fi

#Password addition
PASSWORD=$(date %s%N | sha256sum | head -c10)
echo ${PASSWORD} | passwd --stdin ${USERNAME}
if [[ ${?} = 0 ]]
then
 echo "Password ${PASSWORD} successfullly assigned............"
else
 echo "Error occured - Password............."
 exit 1
fi

#forcing next try password
passwd -e ${USERNAME}

echo "USERNAME- ${USERNAME} PASSWORD- ${PASSWORD} HOSTNAME- $(hostname)"

exit 0
