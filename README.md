### Monitoring setup using Grafana and Prometheus.

#### network setup
<p>
dockernetwork run.sh, sets up the network that maybe used by docker containers. To be able to access host ip via 192.168.0.1, the containers need to use <code> --net=dockernet </code> during docker run.
</p>

#### grafana and prometheus
<p> Each of Prometheus and Grafana is setup using a docker container.  Grafana config can be done by using the conf.ini file. For Prometheus config, yaml file may be used. The config files are mounted during docker run to keep them dynamic. </p>

#### architechture diagram
![alt text](https://prometheus.io/assets/architecture.png)
