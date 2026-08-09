resource aws_eks_cluster "this"{
    name=var.cluster_name
    role_arn=aws_iam_role.eks-cluster-role.arn
    version="1.27"
    vpc_config{
        subnet_ids=[
            var.private_subnet_id_1,
            var.private_subnet_id_2,
        ]
        endpoint_public_access=true
        endpoint_private_access=true

    }
    depends_on=[aws_iam_role_policy_attachment.eks-cluster-policy-attach   ]
}

resource "aws_eks_node_group" "this"{
    cluster_name=var.cluster_name
    node_group_name="${var.cluster_name}-nodes"
    node_role_arn= aws_iam_role.eks-node-group-role.arn
    subnet_ids=[
        var.private_subnet_id_1,
        var.private_subnet_id_2,
    ]
    capacity_type="ON_DEMAND"
    instance_types=[var.instance_type]
    scaling_config{
            desired_size=2
            max_size=3
            min_size=1
    }

    depends_on=[]
    

}