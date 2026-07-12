# Azure Cloud Fundamentals and Data Pipeline using Azure Data Factory

## About the Project

This was my first hands-on experience with Microsoft Azure. The goal of this assignment was to understand the basic Azure services and build a simple end-to-end data pipeline using Azure Data Factory (ADF).

During this project, I learned how different Azure services work together, starting from storing a CSV file in Azure Blob Storage to copying it to another location using an ADF pipeline.

## What I Did

- Created a Resource Group to organize Azure resources.
- Created an Azure Storage Account.
- Created a Blob Container and uploaded a CSV file.
- Created an Azure Data Factory instance.
- Connected Azure Blob Storage using a Linked Service.
- Created Source and Destination datasets.
- Used the **Get Metadata** activity to check the source file.
- Built a pipeline using the **Copy Data** activity.
- Ran the pipeline successfully and monitored its execution.
- Assigned Reader and Contributor roles for Azure Data Factory.

## Azure Services Used

- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory (ADF)
- Azure IAM 

## Pipeline Flow


Create resource group ---> CSV File upload ---> Azure Blob Storage using container ---> ADF Creation ---> Get Metadata ---> copy data --->  connecting metadata to copy data ---> IAM role assignment (reader and contributor) ---> Destination File

## Outcome

The pipeline executed successfully and copied the CSV file from the source location to the destination location. The metadata of the source file was also validated before the copy operation.

## What I Learned

I became familiar with the Azure Portal, Storage Accounts, Blob Containers, Azure Data Factory, Linked Services, Datasets, Pipelines, and basic
(IAM) role assignments. This assignment gave me a practical understanding of how Azure Data Factory is used to move data between storage locations in a cloud environment.
