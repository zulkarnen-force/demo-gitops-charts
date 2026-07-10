{{/*
Expand the name of the chart.
*/}}
{{- define "demo-nextjs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a fully qualified application name.
*/}}
{{- define "demo-nextjs.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "demo-nextjs.name" . }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Chart label.
*/}}
{{- define "demo-nextjs.chart" -}}
{{- printf "%s-%s" .Chart.Name (.Chart.Version | replace "+" "_") | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels.
These MUST remain stable because they are used by Deployment selectors.
*/}}
{{- define "demo-nextjs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "demo-nextjs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "demo-nextjs.labels" -}}
helm.sh/chart: {{ include "demo-nextjs.chart" . }}
{{ include "demo-nextjs.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Service Account name.
*/}}
{{- define "demo-nextjs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "demo-nextjs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "demo-nextjs.configmapName" -}}
{{ include "demo-nextjs.fullname" . }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "demo-nextjs.secretName" -}}
{{ include "demo-nextjs.fullname" . }}
{{- end }}

{{/*
Service name.
*/}}
{{- define "demo-nextjs.serviceName" -}}
{{ include "demo-nextjs.fullname" . }}
{{- end }}

{{/*
Ingress name.
*/}}
{{- define "demo-nextjs.ingressName" -}}
{{ include "demo-nextjs.fullname" . }}
{{- end }}