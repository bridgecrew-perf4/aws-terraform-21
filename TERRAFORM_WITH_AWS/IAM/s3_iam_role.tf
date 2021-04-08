 
 data "template_file" "mydata" {
   template = file(IAM_Policy_and_Role/s3-iam-policy.json)

   vars = {
     bucket_name = var.bucket_name
   }

 }

output "bucket_id" {
 value = "data.template_file.mydata.rendered" 

}