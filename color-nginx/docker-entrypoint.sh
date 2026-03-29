#!/bin/bash
set -e

CERT_DIR="/etc/nginx/certs"
HTML_DIR="/usr/share/nginx/html"
HOST_ID="${HOSTNAME:-default-container}"

mkdir -p "$CERT_DIR"

if [ ! -f "$CERT_DIR/server.crt" ] || [ ! -f "$CERT_DIR/server.key" ]; then
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout "$CERT_DIR/server.key" \
    -out "$CERT_DIR/server.crt" \
    -subj "/CN=localhost"
fi

COLORS=("red" "blue" "green" "yellow" "orange" "purple" "pink" "cyan" "white")

SUM=$(echo -n "$HOST_ID" | cksum | awk '{print $1}')
INDEX=$((SUM % ${#COLORS[@]}))
COLOR="${COLORS[$INDEX]}"

cat > "$HTML_DIR/index.html" <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Container Color</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: ${COLOR};
            color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        h1 {
            font-size: 72px;
            margin: 0;
            text-transform: uppercase;
        }
        p {
            font-size: 24px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>${COLOR}</h1>
    <p>Container: ${HOST_ID}</p>
</body>
</html>
EOF

exec "$@"
