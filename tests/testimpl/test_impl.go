package testimpl

import (
	"context"
	"os"
	"strconv"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	apiManagement "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/apimanagement/armapimanagement"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestApiManagementModule(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	t.Run("doesApiManagementApiExist", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		serviceName := terraform.Output(t, ctx.TerratestTerraformOptions(), "api_management_name")
		apiName := terraform.Output(t, ctx.TerratestTerraformOptions(), "api_name")
		isCurrent := terraform.Output(t, ctx.TerratestTerraformOptions(), "is_current")

		options := arm.ClientOptions{
			ClientOptions: azcore.ClientOptions{
				Cloud: cloud.AzurePublic,
			},
		}

		apiClient, err := apiManagement.NewAPIClient(subscriptionId, credential, &options)
		if err != nil {
			t.Fatalf("Error getting API Management api client: %v", err)
		}

		api, err := apiClient.Get(context.Background(), resourceGroupName, serviceName, apiName, nil)
		if err != nil {
			t.Fatalf("Error getting API Management api: %v", err)
		}

		assert.Equal(t, isCurrent, strconv.FormatBool(*api.Properties.IsCurrent), "The API Management API 'is_current' property does not match the expected value")
	})
}
