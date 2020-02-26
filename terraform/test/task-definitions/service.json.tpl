[
  {
    "name": "static-json",
    "image": "${app_image}",
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]
