{{/* Common PostHog definitions */}}

{{- define "posthog.posthogSecretKey.existingSecret" }}
  {{- if .Values.posthogSecretKey.existingSecret -}}
    {{- .Values.posthogSecretKey.existingSecret -}}
  {{- else -}}
    {{- template "posthog.fullname" . -}}
  {{- end -}}
{{- end }}

{{- define "posthog.posthogSaltKeys.existingSecret" }}
  {{- if .Values.posthogSaltKeys.existingSecret -}}
    {{- .Values.posthogSaltKeys.existingSecret -}}
  {{- else -}}
    {{- template "posthog.fullname" . -}}
  {{- end -}}
{{- end }}

{{- define "snippet.posthog-env" }}
- name: SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ template "posthog.posthogSecretKey.existingSecret" . }}
      key: {{ .Values.posthogSecretKey.existingSecretKey }}
- name: ENCRYPTION_SALT_KEYS
  valueFrom:
    secretKeyRef:
      name: {{ template "posthog.posthogSaltKeys.existingSecret" . }}
      key: {{ .Values.posthogSaltKeys.existingSecretKey }}
- name: SITE_URL
  value: {{ template "posthog.site.url" . }}
- name: DEPLOYMENT
  value: {{ template "posthog.deploymentEnv" . }}
- name: CAPTURE_INTERNAL_METRICS
  value: {{ .Values.web.internalMetrics.capture | quote }}
- name: HELM_INSTALL_INFO
  value: {{ template "posthog.helmInstallInfo" . }}
- name: LOGGING_FORMATTER_NAME
  value: json
{{- end }}

{{- define "snippet.posthog-sentry-env" }}
- name: SENTRY_DSN
  value: {{ .Values.sentryDSN | quote }}
{{- end }}
