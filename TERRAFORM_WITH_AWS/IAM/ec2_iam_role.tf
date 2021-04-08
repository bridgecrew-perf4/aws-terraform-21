resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.ec2_role.id

  policy = file(IAM_Policy_and_Role/ec2-iam-policy.json)
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = file(IAM_Policy_and_Role/ec2-assume-policy.json)
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role
}
