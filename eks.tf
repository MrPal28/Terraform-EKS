module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "~> 21.00"

    name               = local.name
    endpoint_public_access = true


    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    control_plane_subnet_ids = module.vpc.intra_subnets

    # cluster_addons = {
    #     vpc-cni = {
    #         most-recent = true
    #     }
    #     kube-proxy = {
    #         most-recent = true
    #     }
    #     core-dns = {
    #         most-recent = true
    #     }
    # }

    addons = {
    coredns                = {
        most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
    kube-proxy             = {
        most_recent = true
    }
    vpc-cni                = {
      most_recent = true
    }
  }

    # eks_managed_node_group_defaults = {
    #     instance_type = ["t2.micro"]
    #     attach_cluster_primary_security_group = true
    
    # }

      # EKS Managed Node Group(s)
    eks_managed_node_groups = {
    ap-cluster-ng = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.micro"]

      min_size     = 2
      max_size     = 3
      desired_size = 2

      capacity_type = "SPOT"
    }
  }

    tags = {
    Environment = local.env
    Terraform   = "true"
  }
}
