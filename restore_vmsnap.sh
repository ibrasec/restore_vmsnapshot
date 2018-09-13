#/bin/bash

# This script is used to restore the virtual machine to a certain snapshot,
# it is better to work with crontab, so that it is scheduled to restore
# every certain period of time, as example, to restore the snapshot of a certain
# virtual machine every midnight we crontab -e
# 0 0 * * *      ./vmsnap_restore.sh <vm-name> <snapshot-name>

vm_name=$1
snap_name=$2

# checking the vboxmanage is installed
command -v vboxmanage >/dev/null 2>&1 || { echo >&2 "The script requires vboxmanage \
but it's not installed.  Aborting."; exit 1; }
# 
# checking the existance of the passed virtual machine name
vboxmanage list vms | grep -q "$vm_name"
 if [ "$?" -eq "0" ]
then
    #echo "EXists"
    # checking if the snapshot name or its UUID exists
    vboxmanage snapshot ubu-16 list | grep -q "$snap_name"
    if [ "$?" -eq "0" ]
    then
        vboxmanage showvminfo ubu-16 | grep -qE "running|paused"
        running_or_paused=$?
        vboxmanage showvminfo ubu-16 | grep -qE "saved|powered off"
        saved_or_off=$?
        if [ "$running_or_paused" -eq "0" ]
        then
            echo ""
            echo "[-] Saving the State of the Virtual machine"
            vboxmanage controlvm $vm_name savestate
            sleep 5
            echo ""
            echo "[-] Restoring the snapshot"
            vboxmanage snapshot $vm_name restore "$snap_name"
            sleep 5
            echo ""
            echo "[-] Starting the Virtualmachine"
            vboxmanage startvm $vm_name
        elif [ "$saved_or_off" -eq "0" ]
        then
            echo ""
            echo "[-] Restoring the snapshot"
            vboxmanage snapshot $vm_name restore $snap_name
            wait
            echo ""
            echo "[-] Starting the Virtualmachine"
            vboxmanage startvm $vm_name
        else
            echo "Warning: undetermined state..."
            echo "Exiting doing nothing"
        fi
    else
        echo "Warning: This virtual machine snapshot name/UUID doesn't exists"
    fi
else
    echo "Warning: This virtual machine doesn't exists"
fi
