#!/usr/bin/env bash
echo "[INFO] Stopping and removing Pawns.app peer container..."
docker stop pawns-peer-node 2>/dev/null || true
docker rm pawns-peer-node 2>/dev/null || true
echo "[SUCCESS] Pawns.app node has been terminated."
