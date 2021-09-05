#!/bin/sh
set -e

if [ -d plugins ]; then
  plugin_dirs=$(find plugins -mindepth 1 -maxdepth 1 -type d)
  echo "plugins dirs=${plugin_dirs}"

  mkdir -p custom-plugins

  echo "******* Step building go plugins *******"
  for plugin_name in ${plugin_dirs}; do
    plugin_name=`basename ${plugin_name}`
    echo "Building ${plugin_name}"

    go build -buildmode plugin -a -installsuffix nocgo -o "./custom-plugins/${plugin_name}.so" ./plugins/${plugin_name}

    echo "Build ${plugin_name} successfully"
  done
  echo "******* Done building go plugins *******"
else
   echo "******* Skip building go plugins *******"
fi
