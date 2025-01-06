name "jdk_setup"
description "An jdk setup setup Chef role"
run_list "recipe[jenkins_agent::jdk_setup]"
override_attributes({
  "starter_name" => "Vimalesh N",
})
