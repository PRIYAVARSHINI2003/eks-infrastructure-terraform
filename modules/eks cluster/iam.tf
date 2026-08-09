resource "aws_iam_role" "eks-cluster-role"{
    name="eks-cluster-role"
    assume_role_policy=jsonencode({
        Version="2026-06-12"
        statement=[
            {
                Action="sts:AssumeRole"
                Principal={
                    Service="eks.amazonaws.com"
                }
                Effect="Allow"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attach"{
    role=aws_iam_role.eks-cluster-role.name
    policy_arn="arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks-node-group-role"{
    name="eks-node-group-role"
    assume_role_policy=jsonencode({
        version="2026-06-12"
        statement=[
            {
                Version="2012-10-17"
                Effect="Allow"
                Principal={
                    Service="ec2.amazonaws.com"
                }
                Action="sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "eks-node-group-policy-attach"{
    role=aws_iam_role.eks-node-group-role.name
    policy_arn="arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-node-group-policy-attach-1"{
    role=aws_iam_role.eks-node-group-role.name
    policy_arn="arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "eks-node-group-policy-attach-2"{
    role=aws_iam_role.eks-node-group-role.name
    policy_arn="arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}