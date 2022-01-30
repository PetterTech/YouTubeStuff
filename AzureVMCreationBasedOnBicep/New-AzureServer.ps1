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
                [ValidatePattern('^az-.*',
                     ErrorMessage = "{0} is not a servername in Azure. See Get-Help for more info")]
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

        #Make sure servername is in uppercase

        #Get session variables

        #Get username
        $DeployingUser = [Environment]::UserName

        #Connect to Azure

        #Get correct vnet

        #Get correct OS

    }

    Process {
        #Deploy vm
    }

    End {
        #Disconnect from Azure
    }
}