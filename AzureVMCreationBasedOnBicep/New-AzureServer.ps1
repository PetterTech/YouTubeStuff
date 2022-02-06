function New-AzureServer
    {
    <#
    .SYNOPSIS
    Deploys VM in Azure
    .DESCRIPTION
    Will deploy VM in Azure based on input and certain standards.
    .PARAMETER Name
    The name for the VM. Should always start with "AZ-" followed by a three-letter abbriviation for the region, three letters describing function
    and then two numbers. For example AZ-WEU-APP01 for an application server in Europe.
    .PARAMETER Region
    The region the VM should be deployed to. Must be within a predefined set. Selecting Europe will choose West Europe as Azure region, America will
    choose East US, Asia will choose Southeast Asia.
    .PARAMETER Size
    The size for the VM. Selection is based on standards. For more info on VM sizes in Azure, refer to https://docs.microsoft.com/en-us/azure/virtual-machines/sizes
    Can be changed manually after deployment.
    .PARAMETER OS
    The operating system for the VM. Follows standards and therefore your only choice is Windows or Linux, more specific OS/distro will be chosen for you.
    .EXAMPLE
    New-AzureServer -Name "AZ-WEU-APP01" -Region Europe -Size D2s -OS Windows
    Will deploy a VM named AZ-WEU-APP01 in the West Europe region in Azure. Size will be D2s
    .LINK
    https://pettertech.com
    #>    
        [CmdletBinding()] 
            Param (
                [Parameter(Mandatory=$True,Position=0,HelpMessage='Name for the VM')]
                [ValidatePattern('^az-.*')]
                [string]$Name,
                [Parameter(Mandatory=$True,Position=1,HelpMessage='Region where the VM should be deployed')]
                [ValidateSet('Europe','America','Asia')]
                [string]$Region,
                [Parameter(Mandatory=$True,Position=2,HelpMessage='Size for the VM')]
                [ValidateSet('B2s','D2s','D4s','E4s','F2s')]
                [string]$Size,
                [Parameter(Mandatory=$True,Position=3,HelpMessage='OS the VM should have')]
                [ValidateSet('Windows','Linux')]
                [string]$OS
                )
    Begin {
	    #Verify that name is within standards and matches region
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Validating that VM name is within standards"
        if ($Region -eq "Europe") {
            Write-Verbose "Region is Europe"
            if (!($Name -like "az-weu-*")) {
                Write-Verbose "VM name does not follow standards, input was: $($Name)"
                Write-Error "VM name does not comply with naming standard"
            }
            Write-Verbose "VM name complies with standards"
        }

        if ($Region -eq "America") {
            Write-Verbose "Region is America"
            if (!($Name -like "az-eus-*")) {
                Write-Verbose "VM name does not follow standards, input was: $($Name)"
                Write-Error "VM name does not comply with naming standard"
            }
            Write-Verbose "VM name complies with standards"
        }

        if ($Region -eq "Asia") {
            Write-Verbose "Region is Asia"
            if (!($Name -like "az-sea-*")) {
                Write-Verbose "VM name does not follow standards, input was: $($Name)"
                Write-Error "VM name does not comply with naming standard"
            }
            Write-Verbose "VM name complies with standards"
        }
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Validating that VM name is within standards" -Completed

        #Make sure servername is in uppercase
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Converting servername to uppercase"
        try {
            Write-Verbose "Name before conversion: $($Name)"
            $Name = $Name.ToUpper()
            Write-Verbose "Name after conversion: $($Name)"
        }
        catch {
            Write-Verbose "Something failed during name conversion"
            $Error[0] | Out-Host
            Write-Error "Failed to convert VM name to uppercase"
        }
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Converting servername to uppercase" -Completed

        #Convert size to Azure readable format
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Converting size to Azure readable size"
        Write-Verbose "Converting size to Azure formatted size name. Input: $($Size)"
        switch ($Size) {
            "B2s" {$VMSize =  "Standard_B2s" }
            "D2s" {$VMSize =  "Standard_D2s_v4" }
            "D4s" {$VMSize =  "Standard_D4s_v4" }
            "E4s" {$VMSize =  "Standard_E4s_v4" }
            "F2s" {$VMSize =  "Standard_F2s_v2" }
            Default {$VMSize = "Borked"}
        }
        Write-Verbose "Done converting size to Azure formatted size name. Output: $($VMsize)"

        if ($VMSize -eq "Borked") {
            Write-Error "Failed to match size to Azure readable size"
        }
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Converting size to Azure readable size" -Completed

        #Get session variables

        #Get username
        $DeployingUser = [Environment]::UserName

        #Connect to Azure
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Connecting to Azure"
        try {
            Write-Verbose "Trying to connect to Azure"
            Connect-AzAccount | Out-Null
            Write-Verbose "Attempt complete"
        }
        catch {
            Write-Verbose "Something failed during connection to Azure"
            $Error[0] | Out-Host
            Write-Error "Failed to connect to Azure"
        }
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Connecting to Azure" -Completed

        #Get correct resource group based on region

        #Get correct region as a variabe
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Getting correct Azure region"
        try {
            $AllAzRegions = Get-AzLocation
        }
        catch {
            Write-Verbose "Something failed during Azure region getting"
            $Error[0] | Out-Host
            Write-Error "Failed to get correct Azure region"                 
        }

        try {
            switch ($Region) {
                "America" {$AzRegion = $AllAzRegions | Where-Object {$_.Location -eq "eastus"}}
                "Europe" {$AzRegion = $AllAzRegions | Where-Object {$_.Location -eq "westeurope"}}
                "Asia" {$AzRegion = $AllAzRegions | Where-Object {$_.Location -eq "southeastasia"}}
                Default {$vNet = "Borked"}
            }
            if ($vNet -eq "Borked") {
                Write-Error "Failed to match region to vNet"
            }            
        }
        catch {
            Write-Verbose "Something failed during vNet getting"
            $Error[0] | Out-Host
            Write-Error "Failed to get correct vNet"            
        }
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Getting correct Azure region" -Completed

        #Get correct vNet
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Getting correct vNet"
        try {
            switch ($Region) {
                "America" {$vNet = Get-AzVirtualNetwork -Name vnet-america}
                "Europe" {$vNet = Get-AzVirtualNetwork -Name vnet-europe}
                "Asia" {$vNet = Get-AzVirtualNetwork -Name vnet-asia}
                Default {$vNet = "Borked"}
            }
            if ($vNet -eq "Borked") {
                Write-Error "Failed to match region to vNet"
            }            
        }
        catch {
            Write-Verbose "Something failed during vNet getting"
            $Error[0] | Out-Host
            Write-Error "Failed to get correct vNet"            
        }
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Getting correct vNet" -Completed

        #Get subnet ID
        try {
            $subnet = $vNet | Get-AzVirtualNetworkSubnetConfig
        }
        catch {
            Write-Error "Failed to get subnet"
        }

        #Get correct VM image SKU
        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Getting correct VM image SKU"
        try {
            switch ($OS) {
                "Windows" {$ImageSKU = Get-AzVMImage -Location $AzRegion.Location -PublisherName "microsoftWindowsServer" -Offer "windowsserver" -Skus "2022-datacenter-g2" | Select-Object -Last 1}
                "Linux" {$ImageSKU = Get-AzVMImage -Location $AzRegion.Location -PublisherName "Canonical" -Offer "0001-com-ubuntu-server-focal" -Skus "20_04-lts-gen2" | Select-Object -Last 1}
                Default {$ImageSKU = "Borked"}
            }
            if ($ImageSKU -eq "Borked") {
                Write-Error "Failed to match OS to image"
            }            
        }
        catch {
            Write-Verbose "Something failed during image getting"
            $Error[0] | Out-Host
            Write-Error "Failed to get correct image"            
        }

        Write-Progress -Activity "Deploying Azure server" -Status "In preparation phase" -CurrentOperation "Getting correct VM image SKU" -Completed
        
    }

    Process {
        #Create bicep parameter file based on template
        #Grab default parameter file
        try {
            $DefaultParameterFile = Get-Content .\main.parameters.json | ConvertFrom-Json
        }
        catch {
            Write-Error "Failed to import default parameter file"
        }

        #Editing parameter file
        $DefaultParameterFile.parameters.vmName.value = $Name
        $DefaultParameterFile.parameters.location.value = $AzRegion.DisplayName
        $DefaultParameterFile.parameters.deployingUser.value = $DeployingUser
        $DefaultParameterFile.parameters.vmSize.value = $VMSize
        $DefaultParameterFile.parameters.imageOffer.value = $ImageSKU.offer
        $DefaultParameterFile.parameters.imageSku.value = $ImageSKU.skus
        $DefaultParameterFile.parameters.imageVersion.value = $ImageSKU.Version
        $DefaultParameterFile.parameters.imagePublisher.value = $ImageSKU.PublisherName
        $DefaultParameterFile.parameters.subnetID.value = $subnet.Id

        #Exporting to new parameter file
        $DefaultParameterFile | ConvertTo-Json | Out-File .\newparameterfile.json

        #Deploy vm
        try {
          New-AzResourceGroupDeployment -ResourceGroupName "rg-EULandingZone" -TemplateFile .\main.bicep -TemplateParameterFile .\newparameterfile.json
        }
        catch {
          $Error[0] | Out-Host
          Write-Error "Deployment failed"  
        }
    }

    End {
        #Disconnect from Azure
        try {
        Disconnect-AzAccount | Out-Null
            
        }
        catch {
            
        }
    }
}