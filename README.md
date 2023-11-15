# azure-private-build-agent-docker-python
Docker image to run a private build agent in azure with python tools installed

I have been struggling quite some time to get private build agents working, so hence would like to share my work.

The dockerfile comes with 4 versions of python pre-installed as tools, use the docker compose file to build the container, After deploying the container the agent should show up in your agent pool in azure devops.


I also added some comments in the dockerfile and docker compose which explain the why, so you can then adapt it to your own needs. 



enjoy.