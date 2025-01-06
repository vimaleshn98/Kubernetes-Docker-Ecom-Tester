name "docker_setup"
description "An example Chef role"
run_list "recipe[jenkins_agent::docker_setup]"
override_attributes({
  "starter_name" => "Vimalesh N",
})
