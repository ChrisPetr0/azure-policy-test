

# list all regions available in a subscription
$regions = az account list-locations | ConvertFrom-Json

# filter out "logical" regions
$phys_regions = $regions | Where-Object {$_.metadata.regiontype -like 'physical'}

$phys_regions_sorted = $phys_regions | Sort-Object -Property regionalDisplayName -Descending


# print json structure for template
foreach ($region in $phys_regions_sorted){
$json_struct = `
@"
{
  "label": "$($region.regionalDisplayName)",
  "value": "$($region.name)"
},
"@
Write-Host $json_struct
}
