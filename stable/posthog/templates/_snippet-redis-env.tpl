{{/* Common Redis ENV variables */}}
{{- define "snippet.redis-env" }}

- name: POSTHOG_REDIS_HOST
  value: {{ include "posthog.redis.host" . }}

- name: POSTHOG_REDIS_PORT
  value: {{ include "posthog.redis.port" . }}

{{- if (include "posthog.redis.auth.enabled" .) }}
- name: POSTHOG_REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "posthog.redis.secretName" . }}
      key: {{ include "posthog.redis.secretPasswordKey" . }}
{{- end }}
{{- end }}

{{- define "snippet.session-recording-redis-env" }}
- name: POSTHOG_SESSION_RECORDING_REDIS_HOST
  value: {{ include "posthog.sessionRecordingRedis.host" . }}

- name: POSTHOG_SESSION_RECORDING_REDIS_PORT
  value: {{ include "posthog.sessionRecordingRedis.port" . }}
{{- end }}

{{/* Common Redis7 ENV variables */}}
{{- define "snippet.redis7-env" }}

- name: CDP_REDIS_HOST
  value: {{ include "posthog.redis7.host" . }}

- name: CDP_REDIS_PORT
  value: {{ include "posthog.redis7.port" . }}

{{- end }}
