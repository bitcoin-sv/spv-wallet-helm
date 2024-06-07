{{/*
Expand the name of the chart.
*/}}
{{- define "spv-wallet-admin-keygen.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 58 chars and adding chart version because some Kubernetes name fields are limited to 63 chars and we want to add a unique value.
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spv-wallet-admin-keygen.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- printf "%s-%s" (printf  "%s-%s" .Values.fullnameOverride | trunc 57 | trimSuffix "-") .Chart.Version}}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" (.Release.Name | trunc 57 | trimSuffix "-") .Chart.Version }}
{{- else }}
{{- printf "%s-%s" (printf  "%s-%s" .Release.Name $name | trunc 57 | trimSuffix "-") .Chart.Version }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spv-wallet-admin-keygen.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spv-wallet-admin-keygen.labels" -}}
helm.sh/chart: {{ include "spv-wallet-admin-keygen.chart" . }}
{{ include "spv-wallet-admin-keygen.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spv-wallet-admin-keygen.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spv-wallet-admin-keygen.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spv-wallet-admin-keygen.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spv-wallet-admin-keygen.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
