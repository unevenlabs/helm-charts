{{/* vim: set filetype=mustache: */}}
{{/*
Define the name of the chart/application.
*/}}
{{- define "application.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "application.labels.selector" -}}
app: {{ template "application.name" . }}
{{- end -}}

{{- define "application.labels.unevenlabs" -}}
{{ template "application.labels.selector" . }}
{{- if .Values.deployment.enabled }}
appVersion: "{{ .Values.deployment.image.tag }}"
{{- end }}
{{- end -}}

{{- define "application.labels.chart" -}}
Environment: {{ .Values.labels.environment }}
Owner: {{ .Values.labels.owner }}
Application: {{ .Values.labels.application }}
Chain:  {{ .Values.labels.chain }}
provider: unevenlabs
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
release: {{ .Release.Name | quote }}
heritage: {{ .Release.Service | quote }}
{{- end -}}
{{/*
Renders a value that contains template.
Usage:
{{ include "application.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "application.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{- define "application.namespace" -}}

        {{- if .Values.namespaceOverride }}
            {{- .Values.namespaceOverride -}}
        {{- else -}}
            {{- .Release.Namespace -}}
        {{- end -}}

{{- end }}

{{- define "vault.annotations" -}}
{{- $ := index $ 0 -}}
{{- $vault := index . 1 -}}
vault.security.banzaicloud.io/vault-addr: "http://vault.vault:8200"
{{- if $vault.role }}
vault.security.banzaicloud.io/vault-role: {{ $vault.role }}
{{- end }}
{{- if $vault.path }}
vault.security.banzaicloud.io/vault-path: {{ $vault.path }}
{{- end }}
{{- if $vault.secretsFile.enabled }}
vault.security.banzaicloud.io/vault-agent-configmap: {{ template "application.name" $ }}-vault-secret-files
{{- end }}
{{- end }}
