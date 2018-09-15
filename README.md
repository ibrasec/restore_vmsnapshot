# restore_vm_snapshot

   Imagin you are giving a training course, or a demo or some activity that requires the administrator to restore the virtual machine to a certain snaphsot once that activity has finished, instead of doing this manually every time, this script with the help of crontab could be used to restore the virtual machine to the snapshot


## Requirements
   This script expect that you have virtualbox installed and running
it uses vboxmanage to do its works.

   It has been tested on ubuntu 16.04 with virtualbox version 5.1.38
   
   
## How to use
- simply download the script on your host machine 
or the machine that have your virtualbox running.
- issue the below command to make the code executable:

    ```chmod +x restore_vmsnap```
- make sure that you are able to excute vboxmanage commands on your linux shell,
you should see no error when you type the command:

    ```vboxmanage --version```
- take the virtualmachine name and the snapshot that you want to restor and applied 
to the below command
   ```./restore_vmsnap.sh <virtual-mahcine-name> <snapshot-name>```
   
Note that if there is a space in the snapshot name (ex: Snapshot 1), you should use the the backslash
when you pass it to the script or using single quotes as follows:

   ```./restore_vmsnap.sh <virtual-mahcine-name> Snapshot\ 1```
   
   ```./restore_vmsnap.sh <virtual-mahcine-name> 'Snapshot 1'```


## Warning
The script will not take a snapshot of the associated running virtual machine once it has been activated, this implies that any data stored/added/modified before the script activation moment will be lost and the machine will be restored to the associated snapshot.


## Use with crontab
   The best use of this script is when it is added to the crontab to work every certain period of time
if you have some students and want to restore this machine automatically to its snapshot every week
do this:

```crontab -e```

```0 0 * * 1 <path of the file>/restore_vmsnap.sh <virtual-mahcine-name> <snapshot-name>```

if the previouse crontab didn't work, you might do it follows:

```*/1 * * * * /bin/bash -c "DISPLAY=:0.0 <path of the file>/restore_vmsnap.sh <virtual-mahcine-name> <snapshot-name>"```


\<path of the file\> could be your Download directory or any other directory that has this script,
   as example: /home/user/Downloads
  
To use for every midnight:
  
```crontab -e```

```0 0 * * * \<path of the file\>/restore_vmsnap.sh <virtual-mahcine-name> <snapshot-name>```
  
  
## License
restore_vmsnap is free file: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

restore_vmsnap is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
