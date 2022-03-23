function CntBlue {
    param (
        [switch] $Connect,
        [switch] $Disconnect,
        [string] $Name,
        [double] $Volue,
        [switch] $Info
    )
    $btcom  = '.\bin\btcom.exe'
    $nircmd = '.\bin\nircmd.exe'
    
    if ($Info) {
        $regex = "泛型|閘道|列舉|服務|Avrcp|藍牙 LE 裝置|RFCOMM Protocol TDI|MediaTek Bluetooth Adapter"
        $dev = (Get-PnpDevice -Class Bluetooth) -notmatch ($regex)
        $dev
        return
    }
    if ($Connect) {
        Invoke-Expression "$btcom -n $Name -c -s110b"
        Invoke-Expression "$btcom -n $Name -c -s111e"
        if ($Volue) { Invoke-Expression "$nircmd setsysvolume ((65535*$Volue)/100.0)" }
    }
    if ($Disconnect) {
        Invoke-Expression "$btcom -n $Name -r -s110b"
        Invoke-Expression "$btcom -n $Name -r -s111e"
    }
}
# CntBlue -Info
# CntBlue -Disconnect 'WF-1000XM4'
# CntBlue -Connect 'WF-1000XM4' -Volue:50
