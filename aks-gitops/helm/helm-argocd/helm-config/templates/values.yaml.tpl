installCRDs: false

server:
  extraArgs:
    - --insecure
  ingress:
    enabled: ${ argocd_ingress_enabled }
    annotations:
      kubernetes.io/ingress.class: ${ argocd_ingress_class }
      kubernetes.io/tls-acme: "${ argocd_ingress_tls_acme_enabled }"
      nginx.ingress.kubernetes.io/force-ssl-redirect: true
      nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
      nginx.ingress.kubernetes.io/ssl-passthrough: "${ argocd_ingress_ssl_passthrough_enabled }"
    hosts:
      - ${ argocd_server_host }
    tls:
      - secretName: argocd-secret
        hosts:
          - ${ argocd_server_host }

  config:
    url: https://${ argocd_server_host }
    admin.enabled: "true"
    dex.config: |
      connectors:
        - type: github
          id: github
          name: GitHub
          config:
            clientID: ${ argocd_github_client_id }
            clientSecret: ${ argocd_github_client_secret }
            orgs:
              - name: ${ argocd_github_org_name }

  rbacConfig:
    policy.csv: |
      p, role:dev-team, applications, get, ${ argocd_project }/*, allow
      p, role:dev-team, applications, sync, ${ argocd_project }/*, allow
      p, role:devops-team, applications, get, ${ argocd_project }/*, allow
      p, role:devops-team, applications, sync, ${ argocd_project }/*, allow
      g, DevOps-Engineers-Team:${ github_team }, role:dev-team
      g, DevOps-Engineers-Team:doet-admins , role:devops-team
    scopes: '[groups]'
    policy.matchMode: 'glob'