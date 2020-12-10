http://woshub.com/integrate-drivers-to-windows-install-media/


poswershell
# (convert esd to wim)
dism /export-image /SourceImageFile:"D:\sources\install.esd" /SourceIndex:4 /DestinationImageFile:C:\install.wim /Compress:max /CheckIntegrity  
# extract wim
Mount-WindowsImage -Path C:\mount\ -ImagePath C:\install.wim -Index 1

# Boot.wim to add drivers to setup

# export drivers
Export-WindowsDriver -Online -Destination C:\drivers
# add drivers
Add-WindowsDriver -Path C:\mount\ -Driver C:\drivers -Recurse
# save to wim
Dismount-WindowsImage -Path C:\mount –Save
