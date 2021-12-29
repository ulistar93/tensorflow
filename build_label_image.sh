#!/bin/bash

bazel build -c dbg //tensorflow/lite/examples/label_image:label_image
#bazel build -c opt //tensorflow/lite/examples/label_image:label_image
