#!/bin/zsh

nvidia-docker build -t dl/py3-cu9:cv3-tf1.11-torch.4-mxnet1.3 -f Dockerfile .
