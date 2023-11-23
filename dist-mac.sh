# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Run the jlink
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

./gradlew --info jlink


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# remove any previous output of the packaging
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

rm -rf build/jpackage/*


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Package up the application into an app image (i.e. HelloJavaFXApp.app)
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

jpackage \
  --verbose \
  --type app-image \
  --dest build/jpackage \
  --name HelloJavaFXWorld \
  --vendor "Synapticloop" \
  --module synapticloop.javafx.hellojavafxworld/synapticloop.javafx.hellojavafxworld.HelloApplication \
  --icon src/packaging/icons.icns \
  --app-version 1.0.0 \
  --runtime-image build/image \
  --java-options "-splash:\$APPDIR/splash.png" \
  --mac-sign \
  --mac-entitlements src/packaging/entitlements.plist \
  --mac-signing-key-user-name "$MAC_SIGNING_KEY_NAME" \
  --mac-package-identifier synapticloop.javafx.hellojavafxworld

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Copy over the splashscreen
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

cp src/packaging/splash.png build/jpackage/HelloJavaFXWorld.app/Contents/app


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# You need to now re-codesign everything
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

codesign \
  --entitlements src/packaging/entitlements.plist \
  -vvv \
  --options runtime \
  --force \
  --sign "$MAC_SIGNING_KEY_NAME" \
  build/jpackage/HelloJavaFXWorld.app


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# This will create the disk image (i.e. HelloJavaFXWorld-1.0.0.dmg
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

jpackage \
  --verbose \
  --type dmg \
  --dest build/jpackage \
  --name HelloJavaFXWorld \
  --app-image build/jpackage/HelloJavaFXWorld.app \
  --icon src/packaging/icons.icns \
  --mac-sign \
  --mac-signing-key-user-name "$MAC_SIGNING_KEY_NAME" \
  --mac-package-identifier synapticloop.javafx.hellojavafxworld \
  --mac-package-name HelloJavaFXWorld \
  --mac-entitlements src/packaging/entitlements.plist \
  --vendor Synapticloop \
  --app-version 1.0.0 \
  --copyright "Copyright (c) 2023 Synapticloop"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Now notarise the application
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

xcrun \
  notarytool \
  submit \
  --apple-id $APPLE_ID \
  --team-id $APPLE_TEAM_ID \
  --password $APPLE_HELLO_JAVA_FX_WORLD_APP_PASSWORD \
  build/jpackage/HelloJavaFXWorld-1.0.0.dmg \
  --wait

xcrun \
  stapler \
  staple \
  build/jpackage/HelloJavaFXWorld-1.0.0.dmg


