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
environment: {{ .Values.labels.environment }}
owner: {{ .Values.labels.owner }}
application: {{ .Values.labels.application }}
chain:  {{ .Values.labels.chain }}
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
{{- $vault := index . 1 -}}
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/role: {{ $vault.role | quote }}
{{- range $path := $vault.secretsPath }}
  {{- $name := replace "/" "-" $path }}
vault.hashicorp.com/agent-inject-secret-{{ $name }}: {{ $path | quote }}
vault.hashicorp.com/agent-inject-template-{{ $name }}: |
  {{ "{{- with secret \"" }}{{ $path }}{{ "\" -}}" }}
  {{ "{{ range $k, $v := .Data.data }}" }}
  {{ "export {{ $k }}=\"{{ $v }}\"" }}
  {{ "{{ end }}" }}
  {{ "{{- end -}}" }}
{{- end }}
{{- end }}
