app = hello_world 

.PHONY : docker-build
docker-build :
	docker build -t epwalsh/shiny-server .

.PHONY : docker-run
docker-run :
	docker run --rm --env-file=access.txt -p 80:80 epwalsh/shiny-server

.PHONY : run
run :
	cd $(app) && R --quiet -e "shiny::runApp(launch.browser=TRUE)"
