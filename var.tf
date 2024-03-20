variable "vpc_cidr" {
type= string
}

variable "subnet_cidr" {

type=list(string)


}


variable "subnet_names" {

type=list(string)
default= [ "pub-1","pub-2" ]
}

variable "azs" {
type=list

default =["ap-south-1a","ap-south-1b","ap-south-1c"]
}

