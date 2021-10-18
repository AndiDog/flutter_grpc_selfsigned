# Self-signed CA certificate with Flutter iOS (workaround solution)

```sh
# Keep running in background. This is a dummy TLS server, not a full gRPC server.
./server.sh

# Test connectivity
curl --cacert assets/pki/ca/ca.crt 'https://localhost:13100/'

# Build protobuf
./build-proto.sh

# Start iOS simulator and run the app
flutter run
```
