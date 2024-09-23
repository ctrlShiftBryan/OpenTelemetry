# Goal

I am trying to add https://github.com/ctrlShiftBryan/efk-setup into this repository. My goal is to be able to query my logs in kibana.

## pre-requirements

I have verified that following the readme in https://github.com/ctrlShiftBryan/efk-setup works without issues.

## first step

I have copied the elasticsearch, fluentd and kibana folders from the other repo to this repo and updated me README.md

## problem

The fluentd pod is crashing

```
# NAME                                                    READY   STATUS             RESTARTS        AGE
1 es-cluster-0                                            1/1     Running            0               19m
2 es-cluster-1                                            1/1     Running            0               19m
3 es-cluster-2                                            1/1     Running            0               18m
4 fluentd-hktfs                                           0/1     CrashLoopBackOff   6 (4m25s ago)   10m
5 kibana-5fdfd6fcc4-5lr7w                                 1/1     Running            0               17m
6 nginx                                                   1/1     Running            0               17m
7 opentelemetry-demo-grafana-5956c8d5d5-glh4g             1/1     Running            0               14m
8 opentelemetry-demo-jaeger-6486776578-8mkbq              1/1     Running            0               15m
9 opentelemetry-demo-otelcol-9b8fd64c-snn45               1/1     Running            0               16m
10 opentelemetry-demo-prometheus-server-74975798c7-xtrx6   1/1     Running            0               15m
```

Here is the pod describe output

```
Name:             fluentd-hktfs
Namespace:        otel-demo
Priority:         0
Service Account:  fluentd
Node:             minikube/192.168.64.4
Start Time:       Mon, 23 Sep 2024 08:14:41 -0400
Labels:           app=fluentd
                  controller-revision-hash=85d48c8666
                  pod-template-generation=1
Annotations:      <none>
Status:           Running
IP:               10.244.0.215
IPs:
  IP:           10.244.0.215
Controlled By:  DaemonSet/fluentd
Containers:
  fluentd:
    Container ID:   docker://19796b0a221402b1dd5ee687fbc56b125006d876fbf20d734b443f87b14c675b
    Image:          fluent/fluentd-kubernetes-daemonset:v1.4.2-debian-elasticsearch-1.1
    Image ID:       docker-pullable://fluent/fluentd-kubernetes-daemonset@sha256:ce4885865850d3940f5e5318066897b8502c0b955066392de7fd4ef6f1fd4275
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Mon, 23 Sep 2024 08:20:38 -0400
      Finished:     Mon, 23 Sep 2024 08:20:39 -0400
    Ready:          False
    Restart Count:  6
    Limits:
      memory:  512Mi
    Requests:
      cpu:     100m
      memory:  200Mi
    Environment:
      FLUENT_ELASTICSEARCH_HOST:           elasticsearch.default.svc.cluster.local
      FLUENT_ELASTICSEARCH_PORT:           9200
      FLUENT_ELASTICSEARCH_SCHEME:         http
      FLUENTD_SYSTEMD_CONF:                disable
      FLUENT_CONTAINER_TAIL_EXCLUDE_PATH:  /var/log/containers/fluent*
    Mounts:
      /var/lib/docker/containers from varlibdockercontainers (ro)
      /var/log from varlog (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-7bffq (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       False
  ContainersReady             False
  PodScheduled                True
Volumes:
  varlog:
    Type:          HostPath (bare host directory volume)
    Path:          /var/log
    HostPathType:
  varlibdockercontainers:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/docker/containers
    HostPathType:
  kube-api-access-7bffq:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  10m                  default-scheduler  Successfully assigned otel-demo/fluentd-hktfs to minikube
  Normal   Pulled     9m20s (x5 over 10m)  kubelet            Container image "fluent/fluentd-kubernetes-daemonset:v1.4.2-debian-elasticsearch-1.1" already present on machine
  Normal   Created    9m20s (x5 over 10m)  kubelet            Created container fluentd
  Normal   Started    9m19s (x5 over 10m)  kubelet            Started container fluentd
  Warning  BackOff    49s (x46 over 10m)   kubelet            Back-off restarting failed container fluentd in pod fluentd-hktfs_otel-demo(a4b83369-4d1a-4c45-89a9-19a6eaeace94)
```

and here is the log output

```
2024-09-23 12:25:51 +0000 [info]: parsing config file is succeeded path="/fluentd/etc/fluent.conf"
2024-09-23 12:25:52 +0000 [error]: config error file="/fluentd/etc/fluent.conf" error_class=Fluent::ConfigError error="Exception encountered fetching metadata from Kubernetes API endpoint: pods is forbidden: User \"system:serviceaccount:otel-demo:fluentd\" cannot list resource \"pods\" in API group \"\" at the cluster scope ({\"kind\":\"Status\",\"apiVersion\":\"v1\",\"metadata\":{},\"status\":\"Failure\",\"message\":\"pods is forbidden: User \\\"system:serviceaccount:otel-demo:fluentd\\\" cannot list resource \\\"pods\\\" in API group \\\"\\\" at the cluster scope\",\"reason\":\"Forbidden\",\"details\":{\"kind\":\"pods\"},\"code\":403}\n)"
#<Thread:0x00007f7bd93907b8@/fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/filter_kubernetes_metadata.rb:260 run> terminated with exception (report_on_exception is true):
/fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/kubernetes_metadata_watch_pods.rb:34:in `rescue in start_pod_watch': Exception encountered fetching metadata from Kubernetes API endpoint: pods is forbidden: User "system:serviceaccount:otel-demo:fluentd" cannot list resource "pods" in API group "" at the cluster scope ({"kind":"Status","apiVersion":"v1","metadata":{},"status":"Failure","message":"pods is forbidden: User \"system:serviceaccount:otel-demo:fluentd\" cannot list resource \"pods\" in API group \"\" at the cluster scope","reason":"Forbidden","details":{"kind":"pods"},"code":403} (Fluent::ConfigError)
)
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/kubernetes_metadata_watch_pods.rb:27:in `start_pod_watch'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/filter_kubernetes_metadata.rb:260:in `block in configure'
/fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:66:in `rescue in handle_exception': pods is forbidden: User "system:serviceaccount:otel-demo:fluentd" cannot list resource "pods" in API group "" at the cluster scope (KubeException)
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:57:in `handle_exception'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:181:in `get_entities'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:89:in `block (2 levels) in define_entity_methods'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/kubernetes_metadata_watch_pods.rb:28:in `start_pod_watch'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/filter_kubernetes_metadata.rb:260:in `block in configure'
/fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/abstract_response.rb:223:in `exception_with_response': 403 Forbidden (RestClient::Forbidden)
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/abstract_response.rb:103:in `return!'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/request.rb:809:in `process_result'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/request.rb:725:in `block in transmit'
	from /usr/local/lib/ruby/2.6.0/net/http.rb:920:in `start'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/request.rb:715:in `transmit'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/request.rb:145:in `execute'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/request.rb:52:in `execute'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/rest-client-2.0.2/lib/restclient/resource.rb:51:in `get'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:183:in `block in get_entities'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:58:in `handle_exception'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:181:in `get_entities'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/kubeclient-1.1.4/lib/kubeclient/common.rb:89:in `block (2 levels) in define_entity_methods'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/kubernetes_metadata_watch_pods.rb:28:in `start_pod_watch'
	from /fluentd/vendor/bundle/ruby/2.6.0/gems/fluent-plugin-kubernetes_metadata_filter-2.1.6/lib/fluent/plugin/filter_kubernetes_metadata.rb:260:in `block in configure'
```
