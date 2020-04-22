Welcome to PhotoViewer 3000! 

To run this you will need `docker` and `docker-compose`

Once those are installed, navigate to the root directory

From there, enter the command 'docker-compose up' 

Once all containers are up and running, execute the following command from the root directory to create and populate the db: 

`docker-compose run photo_api rake db:create db:migrate db:seed`

After that, navigate to localhost:8080 and enjoy the app! 

