module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.23.0"
  cluster_name    = local.cluster_name
  cluster_version =  var.kubernetes_version
  vpc_id = module.vpc.vpc_id 
  subnet_ids = module.vpc.private_subnets
  
  enable_irsa = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    instance_types = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker.id]
    key_name = "Deployer"
    
  }

  eks_managed_node_groups = {
    node_group = {
        min_size     = 2
        max_size     = 5
        desired_size = 2
      }
  }

}