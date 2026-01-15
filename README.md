# Task 2: Minimal IRC Client Implementation

This project implements a minimal IRC client using raw TCP sockets in Python, as part of **GDG Recruitments 2026**.

## Features
- Connects to a public IRC server using raw sockets
- Performs IRC handshake (`NICK`, `USER`)
- Joins a channel and exchanges messages
- Handles `PING → PONG` keep-alive messages
- Supports `/join` and `/quit` commands
- Uses threading for concurrent send/receive

