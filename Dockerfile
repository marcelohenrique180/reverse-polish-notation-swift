FROM swiftdocker/swift

WORKDIR /app

ENTRYPOINT swift src/main.swift
