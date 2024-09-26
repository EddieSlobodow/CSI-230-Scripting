function GetIPAddresses($page, $http, $browser) {

$result = @(
[pscustomobject]@{ Page = $page }
[pscustomobject]@{ Http = $http }
[pscustomobject]@{ Browser = $browser }
)

return result

}