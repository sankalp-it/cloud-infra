provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-east-2"
    profile = "cloud19-tf-user-tf"
    #alias = "east2"
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-east-1"
    profile = "cloud19-tf-user-tf"
    alias = "east1"
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "us-west-2"
    profile = "cloud19-tf-user-tf"
    alias = "west2"
}