# Mainflux Helm Chart

Helm Chart for the Mainflux IoT Platform

## Prerequisites

- Helm v3
- Stable & Bitnami Helm repos installed
  ```
  helm repo add stable https://charts.helm.sh/stable
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
  ```
- Nginx Ingress Controller
- If using the mTLS setup:
  - Certificate/Key installed as **TLS secret**
  - Intermediate certificate installed as **Generic secret**

## Configuration

The following table lists the configurable parameters and their default values.

| Parameter                            | Description                                                                | Default      |
| ------------------------------------ | -------------------------------------------------------------------------- | ------------ |
| defaults.logLevel                    | Log level                                                                  | debug        |
| defaults.image.pullPolicy            | Docker Image Pull Policy                                                   | IfNotPresent |
| defaults.image.repository            | Docker Image Repository                                                    | mainflux     |
| defaults.image.tag                   | Docker Image Tag                                                           | 0.12.0       |
| defaults.replicaCount                | Replicas of MQTT adapter, Things, Envoy and Auth                           | 3            |
| defaults.natsPort                    | NATS port                                                                  | 4222         |
| defaults.jaegerCollectorPort         | Jaeger port                                                                | 14268        |
| nginxInternal.mtls.tls               | TLS secret which contains the server cert/key                              |              |
| nginxInternal.mtls.intermediateCrt   | Generic secret which contains the intermediate cert used to verify clients |              |
| ingress.enabled                      | Should the Nginx Ingress be created                                        | true         |
| ingress.hostname                     | Hostname for the Nginx Ingress                                             |              |
| ingress.tls.hostname                 | Hostname of the Nginx Ingress certificate                                  |              |
| ingress.tls.secret                   | TLS secret for the Nginx Ingress                                           |              |
| nats.maxPayload                      | Maximum payload size in bytes that the NATS server will accept             | 268435456    |
| nats.replicaCount                    | NATS replicas                                                              | 3            |
| users.dbPort                         | Users service DB port                                                      | 5432         |
| users.httpPort                       | Users service HTTP port                                                    | 9002         |
| users.grpcPort                       | Users service gRPC port                                                    | 7001         |
| things.dbPort                        | Things service DB port                                                     | 5432         |
| things.httpPort                      | Things service HTTP port                                                   | 9000         |
| things.authGrpcPort                  | Things service Auth gRPC port                                              | 7000         |
| things.authHttpPort                  | Things service Auth HTTP port                                              | 9001        |
| things.redisESPort                   | Things service Redis Event Store port                                      | 6379         |
| things.redisCachePort                | Things service Redis Auth Cache port                                       | 6379         |
| adapter_http.httpPort                | HTTP adapter port                                                          | 8008         |
| mqtt.adapter.mqttPort                | MQTT adapter port                                                          | 1884         |
| mqtt.adapter.wsPort                  | MQTT adapter WS port                                                       | 8081         |
| mqtt.broker.mqttPort                 | MQTT adapter broker port                                                   | 1883         |
| mqtt.broker.wsPort                   | MQTT adapter broker WS port                                                | 8080         |
| mqtt.broker.persistentVolume.size    | MQTT adapter broker data Persistent Volume size                            | 5Gi          |
| mqtt.redisESPort                     | MQTT adapter Event Store port                                              | 6379         |
| mqtt.redisCachePort                  | MQTT adapter Redis Auth Cache port                                         | 6379         |
| adapter_coap.udpPort                 | CoAP adapter UDP port                                                      | 5683         |
| ui.port                              | UI port                                                                    | 3000         |
| bootstrap.enabled                    | Enable bootstrap service                                                   | false        |
| bootstrap.dbPort                     | Bootstrap service DB port                                                  | 5432         |
| bootstrap.httpPort                   | Bootstrap service HTTP port                                                | 9013         |
| bootstrap.redisESPort                | Bootstrap service Redis Event Store port                                   | 6379         |
| influxdb.enabled                     | Enable InfluxDB reader & writer                                            | false        |
| influxdb.dbPort                      | InfluxDB port                                                              | 8086         |
| influxdb.writer.httpPort             | InfluxDB writer HTTP port                                                  | 9006         |
| influxdb.reader.httpPort             | InfluxDB reader HTTP port                                                  | 9005         |
| influxdb.backup.enabled              | Enable InfluxDB backup                                                     | false        |
| influxdb.backup.cronjob.schedule     | Crontab style time schedule for backup execution                           | "0 2 * * *"  |
| adapter_opcua.enabled                | Enable OPC-UA adapter                                                      | false        |
| adapter_opcua.httpPort               | OPC-UA adapter HTTP port                                                   | 8188         |
| adapter_opcua.redisRouteMapPort      | OPC-UA adapter Redis Auth Cache port                                       | 6379         |
| adapter_lora.enabled                 | Enable LoRa adapter                                                        | false        |
| adapter_lora.httpPort                | LoRa adapter HTTP port                                                     | 9017         |
| adapter_lora.redisRouteMapPort       | LoRa adapter Redis Auth Cache port                                         | 6379         |
| twins.enabled                        | Enable twins service                                                       | false        |
| twins.dbPort                         | Twins service DB port                                                      | 27017        |
| twins.httpPort                       | Twins service HTTP port                                                    | 9018         |
| twins.redisCachePort                 | Twins service Redis Cache port                                             | 6379         |
| certs.enabled                        | Enable certs service                                                       | false        |
| notifier_smtp.enabled                | Enable SMTP notifier                                                       | false        |
| notifier_smtp.emailHost              | SMTP host                                                                  | false        |
| notifier_smtp.smtpPort               | SMTP port                                                                  | false        |
| notifier_smtp.fromName               | SMTP notifier `from` name                                                  | false        |
| notifier_smtp.fromEmail              | SMTP `from` email address                                                  | false        |
| notifier_smtp.username               | SMTP username                                                              | false        |
| notifier_smtp.password               | SMTP password                                                              | false        |
| notifier_smtp.secret                 | SMTP secret                                                                | false        |
| notifier_smtp.httpPort               | SMTP notifier HTTP port                                                    | false        |
| loki_stack.enabled                   | Enable Loki_Stack                                                          | true         |

All Mainflux services (both core and add-ons) can have their `logLevel`, `image.pullPolicy`, `image.repository` and `image.tag` overridden.

Mainflux Core is a minimalistic set of required Mainflux services. They are all installed by default:

- users
- things
- adapter_http
- adapter_mqtt
- adapter_coap
- ui

Mainflux Add-ons are optional services that are disabled by default. Find in Configuration table parameters for enabling them, i.e. to enable influxdb reader & writer you should run `helm install` with `--set influxdb=true`.
List of add-ons services in charts:

- bootstrap
- influxdb.writer
- influxdb.reader
- adapter_opcua
- adapter_lora
- twins
- notifier_smtp

By default scale of MQTT adapter, Things, Envoy, Auth and NATS will be set to 3. It's recommended that you set this values to number of your nodes in Kubernetes cluster, i.e. `--set defaults.replicaCount=3 --set nats.replicaCount=3`

**Note:** make sure you run `helm install` with `--dependency-update` flag!