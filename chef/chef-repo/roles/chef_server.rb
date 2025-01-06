name "chef_server"
description "An chef_server setup Chef role"
run_list ["recipe[jenkins_server]",
          "recipe[jenkins_server::admin_store]",
          "recipe[jenkins_server::plugin]",
          "recipe[jenkins_server::private_key]",
          "recipe[jenkins_server::final_setup]",    
          "recipe[jenkins_server::jenkins_agent]"      
        ]
override_attributes({
  "starter_name" => "Vimalesh N",
})
