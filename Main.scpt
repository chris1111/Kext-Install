# Version "1.0" Kext Install
# Base on jackluke work
use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
--	Properties configuting shell
--If Continue
display dialog "Welcome Kext Install
Kext Install is an utility that allows you to install your kexts
in / System / Library / Extensions 
Kext, bundle and plugin files are allow. No backup of the original files is made.
Only Apple kexts can be accepted to be loaded.

Working for Big Sur and Monterey
" with icon note

activate me
set all to paragraphs of (do shell script "ls /Volumes")
set w to choose from list all with prompt " 
To continue, select the volume Monterey 12 you want to use, then press the OK button
The volume will be renamed Monterey-DISK" OK button name "OK" with multiple selections allowed
if w is false then
	display dialog "Quit Installer " with icon note buttons {"EXIT"} default button {"EXIT"}
	return
end if
try
	
	repeat with teil in w
		do shell script "diskutil `diskutil list | awk '/ " & teil & "  / {print $NF}'`"
	end repeat
end try
set theName to "Monterey-DISK"
tell application "Finder"
	set name of disk w to theName
end tell
--If Continue
display dialog "Select  the APFS Monterey-DISK on the list to mount the drive as RW" with icon note
set alldisks to paragraphs of (do shell script "diskutil list")
set nonbootnumber to (count of alldisks)
try
	set alldisks to items 2 thru nonbootnumber of alldisks
	activate
	set your_selected_device_id to (choose from list alldisks with prompt "Choose APFS Monterey-DISK, then click OK to proceed")
	repeat with the_Item in your_selected_device_id
		set the_ID to (do shell script "diskutil list | grep -m 1" & space & quoted form of the_Item & space & "| grep -o 'disk[0-9][a-z][0-9]*'")
		set Check to false
		set tName to your_selected_device_id as text
		if (tName contains "10:" or tName contains "9:" or tName contains "8:" or tName contains "7:" or tName contains "6:" or tName contains "5:" or tName contains "4:" or tName contains "3:" or tName contains "2:" or tName contains "1:" or tName contains "0:") and tName contains "APFS" and (tName does not contain "VM" and tName does not contain "- D" and tName does not contain "Update" and tName does not contain "Preboot" and tName does not contain "Recovery" and tName does not contain "Container" and tName does not contain "Snapshot") then
			set Check to true
		end if
		if Check is true then
			set progress total steps to 5
			set progress additional description to "Analyse Progression"
			delay 2
			set progress completed steps to 1
			
			set progress additional description to "Analyse Progression"
			delay 2
			set progress completed steps to 2
			
			set progress additional description to "Analyse Monterey Disk"
			delay 2
			set progress completed steps to 3
			
			try
				do shell script "mount -o nobrowse -t apfs /dev/" & the_ID & " /System/Volumes/Update/mnt1" with administrator privileges
				do shell script "open /System/Volumes/Update/mnt1/"
				delay 1
				
				display dialog "Click Choose Binaries to proceed.
Wait for the end of the process " with icon note buttons {"Choose Binaries"} default button {"Choose Binaries"}
				
				## Set use_terminal to true to run the script in a terminal
				set use_terminal to true
				## Set exit_terminal to true to leave the terminal session open after script runs
				set exit_terminal to true
				## Set log_file to a file path to have the output captured
				set file_list to ""
				set the_command to quoted form of POSIX path of (path to resource "Patch-Helper" in directory "Scripts")
				set file_list to file_list
				delay 2
				set the_command to the_command & " " & file_list
				try
					if log_file is not missing value then
						set the_command to the_command & " | tee -a " & log_file
					end if
				end try
				try
					set use_terminal to false
				end try
				if not use_terminal then
					do shell script "rm -rf  /Private/tmp/FILES"
					delay 1
					tell application "Finder"
						make new folder at POSIX file "/Private/tmp/" with properties {name:"FILES"}
					end tell
					set strPath to POSIX file "/Private/tmp/FILES"
					set ThePath to "Private:tmp:FILES:" as alias
					display dialog "Please select binaries files" buttons {"Select"} with icon note default button 1
					set theFiles to choose file with prompt "Choos files" default location (path to desktop folder) with multiple selections allowed
					tell application "Finder"
						
						duplicate theFiles to ThePath with replacing
					end tell
					delay 2
					do shell script the_command with administrator privileges
					delay 1
					set progress additional description to "Install Files"
					delay 2
					set progress completed steps to 4
					
					set progress additional description to "Installation Done"
					delay 1
					set progress completed steps to 5
					set progress additional description to "
Patching system
Done. Wait for it to be completed. . ."
					
				end if
				
			on error the error_message number the error_number
				display dialog "Error: " & the error_number & ". " & the error_message buttons {"OK"} default button 1
				quit
			end try
			display dialog "Unmount Snapshot Monterey-DISK" buttons {"OK"} default button 1 with icon note
			do shell script "diskutil unmount /System/Volumes/Update/mnt1"
			display dialog "Install kexts /Volume Snapshot
Monterey-DISK has been modified! Reboot" buttons {"Reboot macOS"} default button 1 with icon note giving up after 10
			tell application "loginwindow"
				«event aevtrrst»
			end tell
		else
			display dialog "You haven't selected any Monterey-DISK" buttons {"Exit"} with icon note giving up after 5
		end if
		
	end repeat
on error the error_message number the error_number
	if the error_number is -128 or the error_number is -1708 then
	else
		display dialog "There are no selected Monterey-DISK snapshots." buttons {"OK"} default button 1 with icon note giving up after 5
	end if
end try
