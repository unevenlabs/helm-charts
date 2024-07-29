{{/* vim: set filetype=mustache: */}}
{{/*
Define the name of the chart/application.
*/}}
{{- define "application.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "application.labels.unevenlabs" -}}
app: {{ template "application.name" . }}
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


{{- define "application.namespace" -}}
    {{- if .Values.namespaceOverride }}
        {{- .Values.namespaceOverride -}}
    {{- else -}}
        {{- .Release.Namespace -}}
    {{- end -}}
{{- end }}
