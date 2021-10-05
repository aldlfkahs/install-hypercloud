#!/bin/bash
openssl req -nodes -new -x509 -keyout ./pki/ca.key -out ./pki/ca.crt -subj "/CN=Hypercloud4 Admission Controller Webhook CA" -days 365 && \
openssl genrsa -out ./pki/hypercloud4-webhook.key 2048 && \
openssl req -new -key ./pki/hypercloud4-webhook.key -subj "/CN=hypercloud4-webhook-svc.hypercloud4-system.svc" \
    | openssl x509 -req -CA ./pki/ca.crt -CAkey ./pki/ca.key -CAcreateserial -out ./pki/hypercloud4-webhook.crt -days 365
openssl pkcs12 -export -in ./pki/hypercloud4-webhook.crt -inkey ./pki/hypercloud4-webhook.key -out ./pki/hypercloud4-webhook.p12 -passout pass:tmax@23
keytool -importkeystore -deststorepass tmax@23 -destkeypass tmax@23 -destkeystore ./pki/hypercloud4-webhook.jks -srckeystore ./pki/hypercloud4-webhook.p12 -srcstoretype PKCS12 -srcstorepass tmax@23
