#!/bin/bash

path=`dirname $0`
path=`cd "$path"; pwd`
path=`cd $path/../../st_flutter_gallery; pwd`
echo "当前目录 $path"
cd $path


path=$path/flutter_native_splash.yaml

echo "yaml件路径 $path"

flutter pub run flutter_native_splash:remove --path=$path