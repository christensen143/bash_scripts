#!/bin/bash

read -rep $'\n#####################\nCNSI Patching Script\n#####################\n\nThis script is intended to help patch this computer. Do you wish to continue? [y or n]\n>' -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e '\nThis script will now end.\n\n#####################\nEnd of Script\n#####################\n'
else
        read -rep $'\nAre you doing a monthly security only patch? [y or n]\n>' -n 1 -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                read -rep $'\nAre you doing a quarterly full patch? [y or n]\n>' -n 1 -r
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                        echo -e '\nThis script will now end.\n\n#####################\nEnd of Script\n#####################\n'
                else
                        read -rep $'\nType y if you wish to continue with a quarterly full patch. Otherwise type n.\n>' -n 1 -r
                        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                                echo -e '\nThis script will now end.\n\n#####################\nEnd of Script\n#####################\n'
                        else
                                echo -e '\nChanging /etc/yum.conf to allow for kernel patching.'
                                sleep 2
                                sed -ri 's/exclude/#exclude/' /etc/yum.conf
                                sleep 2
                                echo -e '\nNow running yum update -y to update system.'
                                sleep 2
                                yum update -y -q
                                sleep 2
                                echo -e '\nChanging /etc/yum.conf back to default setting to not allow for kernel patching.'
                                sleep 2
                                sed -ri 's/#exclude/exclude/' /etc/yum.conf
                                read -rep $'\nThe update has completed. Would you like to reboot? [y or n]\n>' -n 1 -r
                                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                                        echo -e '\nThe update has completed but you still need to reboot your server for the Kernel update to take affect. You will need to do this manually. This script will now end.\n\n#####################\nEnd of Script\n#####################\n'
                                else
                                        echo -e '\n!!!!!!!!!!!!!!!!!!!!!\nThe server will reboot in 5 seconds. If you do not wish to reboot press control-c within the five seconds to stop this script.\n!!!!!!!!!!!!!!!!!!!!!'
                                        sleep 5
                                        reboot
                                fi
                        fi
                fi
        else
                read -rep $'Type y if you wish to continue with a quarterly full patch. Otherwise type n.\n>'
                        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                                echo -e '\nThis script will now end.\n\n#####################\nEnd of Script\n#####################\n'
                        else
                                echo -e '\nNow running yum update -y to update system.'
                                sleep 2
                                yum update --security -y -q
                                sleep 2
                                echo -e '\nThe update has completed. Since you did not update the Kernel it is not necessary to reboot. If you would still like to reboot you can do so manually.\n\n#####################\nEnd of Script\n#####################\n'
                        fi
        fi
fi
