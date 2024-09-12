{{/*
Expand the name of the chart.
*/}}
{{- define "spv-wallet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spv-wallet.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spv-wallet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spv-wallet.labels" -}}
helm.sh/chart: {{ include "spv-wallet.chart" . }}
{{ include "spv-wallet.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spv-wallet.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spv-wallet.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spv-wallet.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spv-wallet.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create domain name for app based on global domain and subdomain if is set
*/}}
{{- define "spv-wallet.domainName" -}}
{{- if .Values.ingress.enabled }}
{{- $domainName := required "When ingress is enabled, then domainName is required" (.Values.ingress.domainName | default .Values.global.domainName) }}
{{- if .Values.ingress.subdomain }}
{{- printf "%s.%s" .Values.ingress.subdomain $domainName }}
{{- else }}
{{- $domainName }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create tls secret name based on either ingress.tlsSecretNameTemplate or fullName
*/}}
{{- define "spv-wallet.tlsSecretName" -}}
{{- if .Values.ingress.tlsSecretNameTemplate }}
{{- tpl .Values.ingress.tlsSecretNameTemplate . }}
{{- else if .Values.global.ingress.tlsSecretNameTemplate }}
{{- tpl .Values.global.ingress.tlsSecretNameTemplate . }}
{{- else }}
{{- include "spv-wallet.fullname" . }}-tls
{{- end }}
{{- end }}
