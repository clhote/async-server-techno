#!/bin/bash
../node_modules/.bin/coffee ../src/app.coffee
../node_modules/.bin/coffee --compile --output ../lib ../src
