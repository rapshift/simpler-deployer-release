#!/bin/bash
nohup java -jar simpler-server-1.0.0.jar  > logs/log.txt 2>&1 &
echo $! > pid.file