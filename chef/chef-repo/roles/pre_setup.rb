name "pre_setup"
description "An JDK setup Chef role"
run_list "recipe[jenkins_agent::crontab_setup]"
override_attributes({
  "starter_name" => "Vimalesh N",
})
