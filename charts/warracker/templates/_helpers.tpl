{{- define "chart.resources" -}}
{{- $name := .name -}}
{{- $values := .Values -}}
{{- $res := index $values $name "resources" | default dict -}}

{{- if not $res }}
  {{- if and (hasKey $values "defaults") (hasKey $values.defaults $name) }}
    {{- $res = index $values.defaults $name "resources" | default dict -}}
  {{- end }}
{{- end }}

{{- if $res | len -}}
resources:
{{- toYaml $res | nindent 2 -}}
{{- else -}}
resources: {}
{{- end }}
{{- end }}
