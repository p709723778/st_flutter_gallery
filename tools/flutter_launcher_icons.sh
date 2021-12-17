#!/bin/bash

path=`dirname $0`
path=`cd "$path"; pwd`
path=`cd $path/../st_flutter_gallery; pwd`
echo "当前目录 $path"
cd $path


path=$path/yaml/flutter_launcher_icons.yaml

echo "yaml件路径 $path"

flutter pub get
flutter pub run flutter_launcher_icons:main -f $path