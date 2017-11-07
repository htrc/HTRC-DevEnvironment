# To create new SSL web server certificate "newcert":
# (below commands assume you're in the same folder as this README file)

# create the key
openssl genrsa -out private/newcert.key.pem 2048
chmod 440 private/newcert.key.pem
chgrp certs private/newcert.key.pem

# and the certificate request
openssl req -config openssl.cnf \
      -key private/newcert.key.pem -new -sha256 \
      -out csr/newcert.csr.pem

# and instruct the CA to sign the certificate
openssl ca -config openssl.cnf \
      -extensions server_cert -days 1825 -notext -md sha256 \
      -in csr/newcert.csr.pem \
      -out certs/newcert.cert.pem
chmod 444 certs/newcert.cert.pem
chgrp certs certs/newcert.cert.pem

# Note: adjust the 'extensions', and 'days' as needed
# -extensions server_cert generates a cert for use with a Web Server
# -extensions usr_cert generates a cert for use as client authentication

# All done, the certificate is in certs/newcert.cert.pem and private key in private/newcert.key.pem


