#Geting something to loop through
$aFewNumbers = 1..1337
$aLotOfNumbers = 1..14748360

#PoC using the statement
foreach ($number in $aFewNumbers) {
    $number.GetType()
}

#Measure using the statement
Measure-Command {
    foreach ($number in $aLotOfNumbers) {
        $number.GetType()
    }
}

#PoC using the method
$aFewNumbers.ForEach({
    $_.GetType()
})

#Measure the method
Measure-Command {
    $aLotOfNumbers.ForEach({
        $_.GetType()
    })
}

#PoC using the alias
$aFewNumbers | foreach {
    $_.GetType()
}

#Measure the alias
Measure-Command {
    $aLotOfNumbers | foreach {
        $_.GetType()
    }  
}

#PoC using the Foreach-Object cmdlet
$aFewNumbers | ForEach-Object {
    $_.GetType()
}

#Measure using the cmdlet
Measure-Command {
    $aLotOfNumbers | ForEach-Object {
        $_.GetType()
    }
}