{{/*
Devuelve el nombre del namespace para el proyecto kargo.
Si .Values.global_app es true, antepone 'kargo_' al nombre del proyecto, si no, lo deja igual.
*/}}
{{- define "kargo-project.namespaceName" -}}
{{- if .Values.global_app }}kargo_{{ .Values.kargo.project.name }}{{ else }}{{ .Values.kargo.project.name }}{{ end -}}
{{- end -}}

