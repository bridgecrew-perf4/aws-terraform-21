resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"

  role = aws_iam_role.lambda_role.id

  policy = file("IAM_Policy_and_Role/lambda-iam-policy.json")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = file("IAM_Policy_and_Role/lambda-iam-policy.json")
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "lambda_profile"
  
  role = aws_iam_role.lambda_role
}
