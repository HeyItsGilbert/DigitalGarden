---
date: 2024-01-02
share: true
title: MQTT
---

# MQTT
A lightweight pub/sub model that allows various tools to communicate their state to be used in a larger context. You can subscribe to topics to learn when a state changes.

This is heavily used by IOT devices.

## Protocol
Works over TCP/IP port 1883. Three message types: Connect, Disconnect, and Publish.

## Broker
This is where messages are published to, as well as where clients subscribe to topics.