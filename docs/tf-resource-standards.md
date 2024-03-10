# Terraform Resource Standards

## Naming

Resources should follow the <resource>-<project>-<environment>-<location>-<instance> formatting; example: 

* `asp-portal-core-${var.environment}-${var.location}-${var.instance}`

If the resource needs to be globally unique a random string should be appended using the random_id resource; example: 

* `apim-portal-core-${var.environment}-${var.location}-${var.instance}-${random_id.environment_id.hex}`

These values should be set in the locals.tf file and then referenced in the resource files.

---

## Tagging

Whenever possible the resource should set the tags property to the project tags which are in the `var.tags` variable.

e.g. `tags = var.tags`