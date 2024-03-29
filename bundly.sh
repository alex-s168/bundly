#!/bin/bash

rm -rf .bundly_build

if [[ "$#" -ne 2 ]]; then
  echo "Invalid arguments!"
  echo "Usage: bundly [kotlin file] [main class name]"
  exit 1
fi

if [ -f "$1" ]; then
  echo "Compiling $1..."
else
  echo "Given file does not exist!"
  exit 1
fi

kotlinc -cp /lib/bundly/ -d .bundly_build $1

if [ $? -eq 0 ]; then
  echo "Compiling done!"
else
  echo "Error occurred during compiling of bundling program!"
  exit $?
fi

if ! [ -f ".bundly_build/$2.class" ]; then
  echo "Given main class does not exist!"
  exit 1
fi

echo "Executing..."

kotlin -cp /lib/bundly/ -cp .bundly_build/ "$2"

if [ $? -eq 0 ]; then
  echo "Done!"
  rm -rf .bundly_build
else
  echo "Error occured execution!"
  rm -rf .bundly_build
  exit $?
fi
