{{- /*
Copyright (c) Mainflux
SPDX-License-Identifier: Apache-2.0
*/ -}}
{{- define "mainflux.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mainflux.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mainflux.gen-certs" -}}
{{- $altNames := list ( printf "%s.%s" (include "mainflux.name" .) .Release.Namespace ) ( printf "%s.%s.svc" (include "mainflux.name" .) .Release.Namespace ) -}}
{{- $ca := genCA "mainflux-ca" 365 -}}
{{- $cert := genSignedCert ( include "mainflux.name" . ) nil $altNames 365 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end -}}