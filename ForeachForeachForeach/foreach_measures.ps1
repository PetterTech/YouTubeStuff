#Getting something to loop through
$aLotOfNumbers = 1..14748360

$i = 1
Write-Host "The statement:"
while ($i -le 5) {
    Measure-Command {foreach ($number in $aLotOfNumbers) {$number.GetType()}} | Select-Object TotalSeconds
    $i++
}

$i = 1
Write-Host "The method:"
while ($i -le 5) {
    Measure-Command {$aLotOfNumbers.ForEach({$_.GetType()})} | Select-Object TotalSeconds
    $i++
}

$i = 1
Write-Host "The alias:"
while ($i -le 5) {
    Measure-Command {$aLotOfNumbers | foreach {$_.GetType()}} | Select-Object TotalSeconds
    $i++
}

$i = 1
Write-Host "The cmdlet:"
while ($i -le 5) {
    Measure-Command {$aLotOfNumbers | ForEach-Object {$_.GetType()}} | Select-Object TotalSeconds
    $i++
}

#Measure the statement
Measure-Command {
    foreach ($number in $aLotOfNumbers) {
        $number.GetType()
    }
}

#Measure the method
Measure-Command {
    $aLotOfNumbers.ForEach({
        $_.GetType()
    })
}

#Measure the alias
Measure-Command {
    $aLotOfNumbers | foreach {
        $_.GetType()
    }  
}

#Measure the cmdlet
Measure-Command {
    $aLotOfNumbers | ForEach-Object {
        $_.GetType()
    }
}