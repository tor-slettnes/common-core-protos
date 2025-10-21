Contents
========

 * [protobuf](protobuf/): Generic ProtoBuf message types, shared amongst applications and services
   - [variant](protobuf/variant/): Container for generic data types, including nested key/value maps and lists (think "binary JSON")
   - [status](protobuf/status/): Types used for status/error reporting
   - [version](protobuf/version/): Generic representation of software versions, including subcomponent versions
   - [signal](protobuf/signal/): Helper types used to categorize asynchronous events streamed from services to their clients
   - [datetime](protobuf/datetime/): Types used to represent calendar time and intervals
   - [quantities](protobuf/quantities/): Representation of various physics units and quantities
   - [request_reply](protobuf/request_reply/): Message types to implement RPCs across transports other than gRPC (such as ZeroMQ)

 * [demo](demo/): gRPC interface definition and associated ProtoBuf message types for the Common Core `Demo` service example

 * [switchboard](switchboard/):  gRPC interface definitions for the `Switchboard` service, to manage runtime dependencies

 * [platform](platform/): gRPC interface definitions and associated ProtoBuf message types for common host/platform services
   - [multilogger](platform/multilogger/): `Upgrade` service, to notify of and install available software upgrades
   - [vfs](platform/vfs/): `VirtualFileSystem` service, to access specific filesystem locations (incl. removable media)
   - [sysconfig](platform/sysconfig/): `SysConfig` service, to access system settings (serial number, product info, hostname, time/timezone, etc)
   - [netconfig](platform/netconfig/): `NetConfig` service, to access network settings (network devices, connections, WiFi networks)
   - [upgrade](platform/upgrade/): `Upgrade` service, to notify of and install available software upgrades
