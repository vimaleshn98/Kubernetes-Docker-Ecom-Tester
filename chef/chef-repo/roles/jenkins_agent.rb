name "jenkins_agent"
description "An example Chef role"
run_list "recipe[jenkins_agent]"
override_attributes({
  "starter_name" => "Vimalesh N",
})
