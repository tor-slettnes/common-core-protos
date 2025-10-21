Contents
========

These files contain settings used by messaging peers to establish their
respective communication channels.

 * `grpc-endpoints-common.yaml` - Used gRPC clients and servers to look up port numbers and optionally listener address (for servers) or service host address(for clients).  The settings are organized by gRPC service name, as defined in the corresponding `.proto` file.

 * `zmq-endpoints-common.yaml` - Used by ZeroMQ endpoints to look up transport type (e.g. `"TCP"`), port numbers, and listener/host address.  The settings are organized by "channel name", identifying a REQ/REP or PUB/SUB messaging channel.  Nominally,
   - REQ/REP channels is used for RPC-like communication based on ProtoBuf messages defined in [request_reply.proto](../cc/protobuf/request_reply/request_reply.proto)
   - PUB/SUB channels is used for asynchronous message publications organized by a leading topic name (the first part of a multi-part ZMQ message) followed by a ProtoBuf payload specific to that topic. The topic name is frequently the same as the fully qualified name of the ProtoBuf message, e.g., [cc.multilogger.platform.Loggable](../cc/platform/multilogger/multilogger.proto).
