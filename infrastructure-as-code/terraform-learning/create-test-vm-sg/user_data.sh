#!/bin/bash

ROLE="${role}"
DB_HOST="${db_host}"

cd /home/ubuntu/tech511-sparta-app/app
export DB_HOST=mongodb://$DB_HOST/posts
pm2 start app.js
