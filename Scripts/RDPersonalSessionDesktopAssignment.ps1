# Arquivo de coleta local de cada broker.
# Gera uma aquivo com os usuario caso o sera o brokers da vez. Caso nao for, gera uma arquivo em branco

$cachePath = "C:\scripts\VDI-Hostnames-Users-local.csv"

try
{
    if (Test-Path $cachePath) 
    {
       Remove-Item $cachePath
    }

    $ResultArray = @()

    $collections = Get-RDSessionCollection | ForEach-Object CollectionName

    foreach ($collection in $collections) {

        $Results = Get-RDPersonalSessionDesktopAssignment -CollectionName $collection

        foreach ($Result in $Results) {

            $Data = [ordered]@{
                        DesktopName = $Result.DesktopName
                        User = $Result.User
                    }

            $Obj = New-Object -TypeName PSObject -property $Data

            $ResultArray += $Obj
        }
    }

    $ResultArray | Export-Csv $cachePath

} catch {
 
    throw $_
}