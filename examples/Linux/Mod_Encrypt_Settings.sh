#!/bin/bash

#    RESTful Interface Tool Sample Script for HPE iLO Products    #
#  Copyright 2014, 2020 Hewlett Packard Enterprise Development LP #

# Description:  This is a sample bash script to configure the     #
#               encryption Settings for Integrated Lights-Out(iLO)#
# NOTE: Secondary Server Address & Port values are not necessarily#
#       optional on certain versions of iLO5                      #

# NOTE:  You will need to replace the USER_LOGIN and PASSWORD     #
#        and other values inside the quotation marks with values  #
#        that are appropriate for your environment.               #

#        You might need to tailor this script for the firmware    #
#        running on your Lights-Out device according to the       #
#        information in "Firmware support information" comment(s).#

#        Double check your values before executing this script.   #
#        Incorrect or mismatched port settings may cause you      #
#        to lose the ability to connect to your Lights-Out device.#

#        The Lights-Out device (not the server) will reset        #
#        automatically to make changes to port settings effective #

#        Firmware support information for this script:            #
#            iLO 5 - All versions                                 #
#            iLO 4 - 1.40 or later.                               #

runLocal(){
  ilorest select ESKM. -u USER_LOGIN -p PASSWORD
  ilorest set KeyManagerConfig/LoginName=username
  ilorest set KeyManagerConfig/Password=password
  ilorest set KeyManagerConfig/AccountGroup=groupname
  ilorest set KeyManagerConfig/ESKMLocalCertificateName=certname
  ilorest set KeyServerRedundancyReq=True
  ilorest set PrimaryKeyServerAddress=0.0.0.0
  ilorest set PrimaryKeyServerPort=1
  ilorest set SecondaryKeyServerAddress=0.0.0.0
  ilorest set SecondaryKeyServerPort=1
  ilorest commit
  ilorest logout
}

runRemote(){
  ilorest select ESKM. --url=$1 --user $2 --password $3
  ilorest set KeyManagerConfig/LoginName=username
  ilorest set KeyManagerConfig/Password=password
  ilorest set KeyManagerConfig/AccountGroup=groupname
  ilorest set KeyManagerConfig/ESKMLocalCertificateName=certname
  ilorest set KeyServerRedundancyReq=True
  ilorest set PrimaryKeyServerAddress=0.0.0.0
  ilorest set PrimaryKeyServerPort=1
  ilorest set SecondaryKeyServerAddress=0.0.0.0
  ilorest set SecondaryKeyServerPort=1
  ilorest commit
  ilorest logout
}

error(){
  echo "Usage:"
  echo        "remote: Mod_Encrypt_Settings.sh ^<iLO url^> ^<iLO username^>  ^<iLO password^>"
  echo        "local:  Mod_Encrypt_Settings.sh"
}

if [ "$#" -eq "3" ]
then 
  runRemote "$1" "$2" "$3"
elif [ "$#" -eq "0" ]
then
  runLocal
else
  error
fi