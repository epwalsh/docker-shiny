# docker-shiny

A Shiny server deployed through Docker with username/password login.

## Requirements

Docker and Git.

## Quick start

**1. Pull or build the docker image.**

You can pull and run the image directly with

```
docker pull epwalsh/shiny-server
```

Or build from scratch:

```
git clone https://github.com/epwalsh/docker-shiny.git && cd docker-shiny
docker build -t epwalsh/shiny-server .
```

**2. Run the docker image locally.**

```
docker run --rm --env-file=access.txt -p 80:80 epwalsh/shiny-server
```

**3. Test it out!**

Open your web browser and go to local host. You should see 
a prompt asking for a username and password.
The username and password are defined in the `access.txt` file and by default
are `shiny` and `password`, respectively. Once you enter those you'll see the
home page of your shiny new Shiny server
:ok_hand: :ok_hand: :ok_hand: :ok_hand: :+1: :+1: :+1:
