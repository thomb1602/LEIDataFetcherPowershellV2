[string]$fileName = 'C:\Repos\Tom\LEIDataFetcherV2\powershelltestfiles\LEICode.csv'
[string]$output = 'C:\Repos\Tom\LEIDataFetcherV2\powershelltestfiles\LEICode_Updated.csv'
[string]$uri = 'https://api.gleif.org/api/v1/lei-records?filter[lei]=' # 261700K5E45DJCF5Z735

$csv = Import-Csv -Path $fileName 
$csv 

foreach ($row in $csv)
{  
    # get from gleif
    Start-Sleep -Seconds 2
    $request = -join ($uri, $row.LegalEntityCode.ToString());
    $response = Invoke-WebRequest -Uri $request
    $json = $response.Content | ConvertFrom-Json    

    # get the name from the response


    # check if it's different
    if ($gleifName -ne $row.LegalEntityName)
    {
        # update csv object
        $row.LegalEntityName = $gleifName
    }      
}
$csv

# export updated object to csv file
$csv | Export-Csv -Path $output -NoTypeInformation






