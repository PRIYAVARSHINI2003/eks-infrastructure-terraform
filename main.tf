module vpc{
    source="./modules/vpc"
}

module eks-cluster{
    source="./modules/eks cluster"
    private_subnet_id_1=module.vpc.subnetid-1
    private_subnet_id_2=module.vpc.subnetid-2
}