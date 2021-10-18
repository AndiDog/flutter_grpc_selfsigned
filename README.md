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

If the TLS certificate is accepted, you should see this log entry (because of the dummy gRPC server not sending any responses):

```text
[VERBOSE-2:ui_dart_state.cc(209)] Unhandled Exception: gRPC Error (code: 4, codeName: DEADLINE_EXCEEDED, message: Deadline exceeded, details: null, rawResponse: null, trailers: {})
```

On TLS failure, you would see something like this:

```text
[VERBOSE-2:ui_dart_state.cc(209)] Unhandled Exception: gRPC Error (code: 14, codeName: UNAVAILABLE, message: Error connecting: HandshakeException: Handshake error in client (OS Error:
	CERTIFICATE_VERIFY_FAILED: application verification failure(handshake.cc:359)), details: null, rawResponse: null, trailers: {})
```
