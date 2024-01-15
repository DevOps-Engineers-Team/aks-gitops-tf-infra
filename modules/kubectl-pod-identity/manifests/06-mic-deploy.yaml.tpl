apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    component: mic
  name: mic
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      component: mic
  template:
    metadata:
      labels:
        component: mic
    spec:
      containers:
      - name: mic
        image: ${image}
        args:
          - "--kubeconfig=/var/lib/kubelet/kubeconfig"
          - "--cloudconfig=/etc/kubernetes/azure.json"
          - "--logtostderr"
        securityContext:
          runAsUser: 0
          readOnlyRootFilesystem: true
        env:
        - name: MIC_POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        resources:
          limits:
            cpu: 200m
            memory: 1024Mi
          requests:
            cpu: 100m
            memory: 256Mi
        volumeMounts:
          - name: kubelet-config
            mountPath: /var/lib/kubelet
            readOnly: true
          - name: certificates
            mountPath: /etc/kubernetes/certs
            readOnly: true
          - name: k8s-azure-file
            mountPath: /etc/kubernetes/azure.json
            readOnly: true
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 5
      volumes:
      - name: kubelet-config
        hostPath:
          path: /var/lib/kubelet
      - name: certificates
        hostPath:
          path: /etc/kubernetes/certs
      - name: k8s-azure-file
        hostPath:
          path: /etc/kubernetes/azure.json
      nodeSelector:
        kubernetes.io/os: linux
