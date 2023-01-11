# Gateway level settings can be only done using Powershell
# Ref: https://learn.microsoft.com/en-us/azure/application-gateway/custom-error

# Run in administrator mode and remove AzureRm module
Uninstall-AzureRm

# Install Azure module if not present
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber

# Import Az.Network module if not loaded in current session
Import-Module Az.Network

# Login to Azure with appropriate Subscription and Tenant (Azure AD) ID
Connect-AzAccount -Subscription <subscription-id> -TenantId  <tenant-id>

# Get the Application Gateway that is to be updated
$appgw = Get-AzApplicationGateway -Name <app-gateway-name> -ResourceGroupName <resource-group>

# Upload an HTML page to a public container, 
# and set it as custom error page for a specific error code 
$updatedgateway = Set-AzApplicationGatewayCustomError -ApplicationGateway $appgw -StatusCode HttpStatus502 -CustomErrorPageUrl <public-url-of-blob>