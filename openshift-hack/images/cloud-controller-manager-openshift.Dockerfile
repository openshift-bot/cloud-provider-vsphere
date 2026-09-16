FROM quay-proxy.ci.openshift.org/openshift/ci:ocp_builder_rhel-9-golang-1.24-openshift-4.20 AS builder
WORKDIR /go/src/github.com/openshift/cloud-provider-vsphere
COPY . .

RUN make binaries

FROM quay-proxy.ci.openshift.org/openshift/ci:ocp_4.20_base-rhel9
COPY --from=builder /go/src/github.com/openshift/cloud-provider-vsphere/.build/vsphere-cloud-controller-manager /bin/vsphere-cloud-controller-manager

LABEL description="vSphere Cloud Controller Manager"

ENTRYPOINT ["/bin/vsphere-cloud-controller-manager"]
