apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    component: nmi
    tier: node
  name: nmi
  namespace: default
spec:
  updateStrategy:
    type: RollingUpdate
  selector:
    matchLabels:
      component: nmi
      tier: node
  template:
    metadata:
      labels:
        component: nmi
        tier: node
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      volumes:
      - hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        name: iptableslock
      - name: kubelet-config
        hostPath:
          path: /etc/default/kubelet
          type: FileOrCreate
      containers:
      - name: nmi
        image: ${image}
        args:
          - "--node=$(NODE_NAME)"
          - "--http-probe-port=8085"
          - "--enableScaleFeatures=true"
          - "--metadata-header-required=true"
        env:
          - name: HOST_IP
            valueFrom:
              fieldRef:
                fieldPath: status.podIP
          - name: NODE_NAME
            valueFrom:
              fieldRef:
                fieldPath: spec.nodeName
        securityContext:
          runAsUser: 0
          capabilities:
            drop:
            - ALL
            add:
            - DAC_READ_SEARCH
            - NET_ADMIN
            - NET_RAW
        resources:
          limits:
            cpu: 200m
            memory: 512Mi
          requests:
            cpu: 100m
            memory: 256Mi
        volumeMounts:
        - mountPath: /run/xtables.lock
          name: iptableslock
        - name: kubelet-config
          mountPath: /etc/default/kubelet
          readOnly: true
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8085
          initialDelaySeconds: 10
          periodSeconds: 5
      nodeSelector:
        kubernetes.io/os: linux