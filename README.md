# docker-shiny

A simple R Shiny server deployed through Docker with username + password authentication
:closed_lock_with_key:
:raised_hands: :raised_hands: :clap: :clap: :clap: :clap:

## Requirements

:whale: Docker and Git :octocat:

## Quick start

**1. Pull or build the docker image.**

You can pull and run the image directly:

```
docker pull epwalsh/shiny-server
```

Or build from scratch: :muscle:

```
git clone https://github.com/epwalsh/docker-shiny.git && cd docker-shiny
docker build -t epwalsh/shiny-server .
```

**2. Run the docker image locally.**

```
docker run --rm --env-file=access.txt -p 80:80 epwalsh/shiny-server
```

> NOTE: If you pulled the image directly and didn't clone the repository,
you'll need to create the `access.txt` file which just has two lines:

```
HT_USER=shiny
HT_PSWD=password
```

**3. Test it out!**

Open your web browser and go to local host. You should see 
a prompt asking for a username and password.
The username and password are defined in the `access.txt` file and by default
are `shiny` and `password`, respectively. Once you enter those you'll see the
home page of your shiny new Shiny server
:ok_hand: :ok_hand: :ok_hand: :ok_hand: :+1: :+1: :+1:
