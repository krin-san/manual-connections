#!/usr/local/bin/bash
# Copyright (C) 2020 Private Internet Access, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Restore cached data
cacheDir='/opt/piavpn-manual/'

if [[ ! $PIA_TOKEN ]]; then
  PIA_TOKEN=$(head -n1 "$cacheDir/token")
  echo -e "Restored \$PIA_TOKEN=$PIA_TOKEN"
fi

if [[ ! $PF_GATEWAY || ! $PF_HOSTNAME ]]; then
  PF_GATEWAY=$(cat "$cacheDir/pf_gateway")
  PF_HOSTNAME=$(cat "$cacheDir/pf_hostname")
  echo -e "Restored \$PF_GATEWAY=$PF_GATEWAY"
  echo -e "Restored \$PF_HOSTNAME=$PF_HOSTNAME"
else
  echo -e "Caching \$PF_GATEWAY and \$PF_HOSTNAME..."
  echo -e "$PF_GATEWAY" > "$cacheDir/pf_gateway"
  echo -e "$PF_HOSTNAME" > "$cacheDir/pf_hostname"
fi

if [[ ! $PAYLOAD_AND_SIGNATURE ]]; then
  PAYLOAD_AND_SIGNATURE=$(cat "$cacheDir/pf_payload")
  echo -e "Restored \$PAYLOAD_AND_SIGNATURE=$PAYLOAD_AND_SIGNATURE"
fi

echo
echo

PF_SLEEP="false" \
  PIA_TOKEN="$PIA_TOKEN" \
  PF_GATEWAY="$PF_GATEWAY" \
  PF_HOSTNAME="$WG_HOSTNAME" \
  PAYLOAD_AND_SIGNATURE="$PAYLOAD_AND_SIGNATURE" \
  ./port_forwarding.sh
