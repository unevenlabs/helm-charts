#!/bin/bash
set -u

result=0

wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
cp kubeval /usr/local/bin

for k8s_version in "${KUBERNETES_VERSION}"
do
    for d in stable/* ; do
        echo ""
        echo "Validating '${d}' against '${k8s_version}' kubernetes version"
        helm template "${d}" | \
          kubeval -v "$k8s_version" \
            --strict \
            --skip-kinds Alertmanager,EnvoyFilter,Prometheus,PrometheusRule,ServiceMonitor,VirtualService,Elasticsearch,Kibana,Beat,CustomResourceDefinition,AuthorizationPolicy,Certificate,Issuer \
            -s https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master
        res=$?
        if [ ${res} -ne 0 ]; then
          echo "ERROR found in '${d}'"
          result=1
        fi
    done
done

exit ${result}
