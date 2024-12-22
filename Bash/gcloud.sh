gcloud projects get-iam-policy "terraform-sandbox-441212" --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:foo"
gcloud iam roles describe roles/resourcemanager.projectIamAdmin

# gcloud projects add-iam-policy-binding <YOUR GCLOUD PROJECT ID> --member=serviceAccount:foo  --role=roles/resourcemanager.projectIamAdmin