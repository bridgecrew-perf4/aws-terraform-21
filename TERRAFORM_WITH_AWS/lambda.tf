


data "archive_file" "welcome_message" {
  type        = "zip"
  source_file = "welcome_message.py"
  output_path = locals.output_zip_location
}


resource "aws_lambda_function" "test_lambda" {
  filename      = locals.output_zip_location
  function_name = "HelloLambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "welcome_message.HelloLambda"


  source_code_hash = filebase64sha256(local.output_zip_location)

  runtime = "python 3.8"


}