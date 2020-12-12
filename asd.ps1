


$isoDrive = "D:"
$targetDrive = "H:"

echo remove install.esd-readonly and install.wim-readonly if neccessary



mkdir $targetDrive\drivers
Export-WindowsDriver -Online -Destination $targetDrive\drivers

cp -r $isoDrive\* $targetDrive # install.esd can be skipped

attrib -R $targetDrive\sources\install.esd
Export-WindowsImage -SourceImagePath $targetDrive\sources\install.esd -SourceIndex 4 -DestinationImagePath $targetDrive\sources\install.wim -CompressionType max -CheckIntegrity 
rm $targetDrive\sources\install.esd


mkdir $targetDrive\wim
Mount-WindowsImage -ImagePath $targetDrive\sources\install.wim -Index 1 -Path $targetDrive\wim
Add-WindowsDriver -Path $targetDrive\wim -Driver $targetDrive\drivers -Recurse
Dismount-WindowsImage -Path $targetDrive\wim  -Save

Mount-WindowsImage -ImagePath $targetDrive\sources\boot.wim -Index 1 -Path $targetDrive\wim
Add-WindowsDriver -Path $targetDrive\wim -Driver $targetDrive\drivers -Recurse
Dismount-WindowsImage -Path $targetDrive\wim  -Save
