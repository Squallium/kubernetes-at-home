{{- define "adguard-home.name" -}}
adguard-home
{{- end }}

{{- define "adguard-home.fullname" -}}
{{ include "adguard-home.name" . }}
{{- end }}