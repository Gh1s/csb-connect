# Application mobile commerçants

Ce projet contient l'application mobile à destination des commerçants de la CSB.

## ⚡️ Quickstart

Pour compiler l'application pour Android en mode release :

```bash
BUILD_TYPE=appbundle BUILD_NUMBER=$BUILD_NUMBER ./build.sh -f $ENVIRONMENT.env
```
Si ne marche pas, changement var en manuel

```bash
flutter build appbundle --dart-define=FTPE_URL_API=https://hermes.csb.nc/api --dart-define=ALERTS_TOPIC=alerts
```
Dans ce cas il faudra aussi changer la version manuellement dans le yml (juste incrémenter la mineure)

l'appbundle pourra se trouver  à  ./build/app/outputs/bundle/release/csb-connect.aab

l'appbundle se dépose ensuite sur [google play console](https://play.google.com/console) en test interne dans modifier la release puis drag and drop le fichier aab


Pour compiler l'application pour iOS en mode release :

```bash
BUILD_TYPE=ios BUILD_NUMBER=$BUILD_NUMBER ./build.sh -f $ENVIRONMENT.env
```

Si sa ne marche pas : 

```bash
flutter build ipa --dart-define=FTPE_URL_API=https://hermes.csb.nc/api --dart-define=ALERTS_TOPIC=alerts
```

> `$BUILD_NUMBER` représente le numéro de build. Il doit être unique par version.<br/>
> `$ENVIRONMENT` représente l'environnement de build.

⚠️ Le SDK requis pour build l'application est le 1.26.0-8.0.pre.

## 🧰 Tooling

### Flutter

L'application est écrite avec [Flutter](https://flutter.dev/docs/get-started/install).

### Android Studio

[Android Studio](https://developer.android.com/studio) permet de gérer le code source, installer les SDKs Android, ou encore de gérer les Android Virtual Devices (émulateurs).

### Xcode

TODO: Write Xcode doc.

## 🔑 Keymaterials

## Android

TODO: Write Android keymaterials doc.

## iOS

TODO: Write iOS keymaterials doc.
