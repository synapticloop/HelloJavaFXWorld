This is the base project to build, run, deploy, and publish a disk image 
that is signed and notaried so that it is able to be downloaded from a
website and run by the end user without problem.

Full instructions can be found here:
https://synapticloop.medium.com/jpackage-building-and-deploying-a-java-application-on-macos-3fe48b4cb1d1

In your `~/.zshrc` file put the following environment variables:

```
export MAC_SIGNING_KEY_NAME="YOUR_CERTIFICATE_NAME_HERE"
export APPLE_ID="YOUR_APPLE_ID_HERE_WHICH_MAY_BE_YOUR_EMAIL_ADDRESS"
export APPLE_TEAM_ID="YOUR_APPLE_TEAM_ID_HERE"
export APPLE_HELLO_JAVA_FX_WORLD_APP_PASSWORD="YOUR_NOTARISED_APP_PASSWORD"
```

then run

`./dist-mac.sh`