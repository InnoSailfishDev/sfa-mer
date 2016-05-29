#!/bin/bash
TOOLDIR="$(dirname `which $0`)"
source "$TOOLDIR/utility-functions.inc"
# Download and untar appropriately the Mer SDK. Also try to avoid repetition.

source ~/.hadk.env

mkdir -p "$MER_ROOT/sdks/sdk"

mchapter "4.2"
cd "$MER_ROOT"
minfo "Fetching Mer"
TARBALL=mer-i486-latest-sdk-rolling-chroot-armv7hl-sb2.tar.bz2
[ -f $TARBALL  ] || curl -k -O https://img.merproject.org/images/mer-sdk/$TARBALL || die

minfo "Untaring Mer"
[ -f ${TARBALL}.untarred ] || sudo tar --numeric-owner -p -xjf "$MER_ROOT/$TARBALL" -C "$MER_ROOT/sdks/sdk" || die
touch ${TARBALL}.untarred
minfo "Done with Mer"

echo 'alias sdk=$MER_ROOT/sdks/sdk/mer-sdk-chroot' >> ~/.bashrc
exec bash
echo 'PS1="MerSDK $PS1"' >> ~/.mersdk.profile
cd $HOME
sdk

# These commands are a tmp workaround of glitch when working with target:
zypper ar http://repo.merproject.org/obs/home:/sledge:/mer/latest_i486/ \
curlfix
zypper ref curlfix
zypper dup --from curlfix
