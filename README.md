Monitoring with Prometheus, telegraf. VictoriaMetrics and vmagent.
Visualize with Grafana.

1. cd {clone_dir}/docker/bin; chmod +x *
2. run ./monitoring.sh // This will create the default env.cfg file.
3. vim env.cfg // Change the Base Dir to the correct location. Change passwords if you want.
4. ./monitoring.sh up
