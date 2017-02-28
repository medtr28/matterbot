# matterbot

## creating docker network

~~~
docker network create hubot.net
~~~

## Running Mattermost container

~~~
docker run --net hubot.net --name mattermost-dev -d --publish 8065:8065 mattermost/platform 
~~~

## setting mattermost outgoing webhooks

* callback URL  -> http://matterbot.hubot.net:8080/hubot/incoming
* Trigger Words -> matterbot

## make dockerimage

~~~
docker build -t hubot .
docker images
~~~

~~~
docker run -it -e MATTERMOST_ENDPOINT='/hubot/incoming' \
    -e MATTERMOST_INCOME_URL='http:/matternist-dev.hubot.net:8065/hooks/<<incoming_URL>>' \
    -e MATTERMOST_TOKEN='<<token>>' \
    -e MATTERMOST_HUBOT_USERNAME='matterbot' \
    --net hubot.net --name "matterbot" -d hubot
~~~


