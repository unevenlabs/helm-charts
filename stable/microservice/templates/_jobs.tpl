{{- define "jobs.template" -}}
{{- $ := index $ 0 -}}
{{- $job := index . 1 -}}

{{- if $.Values.vault.enabled }}
  annotations:
{{include "vault.annotations" (list $ $.Values.vault) | indent 4 }}
{{- end }}
spec:
{{- if hasKey $job "securityContext" }}
  {{- if $job.securityContext.runAsUser }}
  securityContext:
    runAsUser: {{ $job.securityContext.runAsUser }}
    {{- if $job.securityContext.runAsGroup }}
    runAsGroup: {{ $job.securityContext.runAsGroup }}
    {{- end }}
    {{- if $job.securityContext.fsGroup }}
    fsGroup: {{ $job.securityContext.fsGroup }}
    {{- end }}
  {{- end }}
{{- end }}
  {{- with $job.nodeSelector }}
  nodeSelector:
{{ toYaml . | indent 4 }}
  {{- end }}
  {{- if $job.parallelism }}
  parallelism: {{ $job.parallelism }}
  {{- end }}
  {{- if $job.completions }}
  completions: {{ $job.completions }}
  {{- end }}
  {{- if $job.activeDeadlineSeconds }}
  activeDeadlineSeconds: {{ $job.activeDeadlineSeconds }}
  {{- end }}
  {{- with $job.tolerations }}
  tolerations:
{{ toYaml . | indent 4 }}
  {{- end }}
  {{- with $job.affinity }}
  affinity:
{{ toYaml . | indent 4 }}
  {{- end }}
  imagePullSecrets:
  - name: {{ $job.imagePullSecrets | default $.Values.deployment.imagePullSecrets | quote }}
  containers:
  - image: "{{ $job.image.repository }}:{{ $job.image.tag }}"
    imagePullPolicy: {{ $job.image.imagePullPolicy }}
    name: {{ $job.name }}
    {{- with $job.env }}
    env:
{{ toYaml . | indent 4 }}
    {{- end }}
    {{- with $job.envFrom }}
    envFrom:
    {{- range $job.envFrom }}
    {{- if (eq .type "configmap") }}
    - configMapRef:
        {{- if .name }}
        name: {{ .name }}
        {{- else if .nameSuffix }}
        name: {{ template "application.name" $ }}-{{ .nameSuffix }}
        {{- else }}
        name: {{ template "application.name" $ }}
        {{- end }}
    {{- end }}
    {{- if (eq .type "secret") }}
    - secretRef:
        {{- if .name }}
        name: {{ .name }}
        {{- else if .nameSuffix }}
        name: {{ template "application.name" $ }}-{{ .nameSuffix }}
        {{- else }}
        name: {{ template "application.name" $ }}
        {{- end }}
    {{- end }}
    {{- end }}
    {{- end }}
    {{- with $job.command }}
    command:
{{ toYaml . | indent 4 }}
    {{- end }}
    {{- with $job.args }}
    args:
{{ toYaml . | indent 4 }}
      {{- end }}
    {{- with $job.resources }}
    resources:
{{ toYaml . | indent 6 }}
    {{- end }}
    {{- with $job.volumeMounts }}
    volumeMounts:
{{ toYaml . | indent 4 }}
    {{- end }}
  restartPolicy: {{ $job.restartPolicy }}
  {{- with $job.volumes }}
  volumes:
{{ toYaml . | indent 4 }}
  {{- end }}
  {{- if $.Values.rbac.jobs.enabled }}
  {{- if $.Values.rbac.serviceAccount.name }}
  serviceAccountName: {{ $.Values.rbac.serviceAccount.name }}
  {{- else }}
  serviceAccountName: {{ template "application.name" $ }}
  {{- end }}
  {{- end }}
{{- end -}}
