#!/bin/bash

sed -i -e "s/\/var\/app\/ondeck/\/var\/app\/current/" app/cache/$APP_ENV/*.php
