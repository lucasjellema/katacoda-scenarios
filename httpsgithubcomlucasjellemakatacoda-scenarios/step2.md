Copy this service definition into the docker-compose.yml file:
<pre class="file" data-filename="docker-compose.yml" data-target="append">
  code-cafe-machine:
    image: katacoda/docker-http-server
    labels:
      - "traefik.backend=code-cafe-machine-echo"
      - "traefik.frontend.rule=Host:machine.code.cafe"
    networks:
      - cafenet

</pre>

Now execute this command to stop and tear down all Docker artifacts created before using docker-compose `docker-compose down`{{execute}}

Let's restart Traefik as well as the newly defined container using docker-compose `docker-compose up -d`{{execute}}.

