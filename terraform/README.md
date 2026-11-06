$env:AUTHENTIK_URL = "https://auth.internal.org"                                                                            pwsh   79  13:34:27 
$env:AUTHENTIK_TOKEN = "placeholder"
$env:VAULT_ADDR = "https://vault.internal.org"
$env:VAULT_TOKEN = "placeholder"


## Extracting ids from authentik

$headers = @{
Authorization = "Bearer $env:AUTHENTIK_TOKEN"
}

$response = Invoke-RestMethod `
    -Uri "https://auth.internal.org/api/v3/stages/identification/" `
-Headers $headers

$response.results |
Where-Object { $_.name -eq "default-authentication-identification" } |
Format-List pk, name, sources