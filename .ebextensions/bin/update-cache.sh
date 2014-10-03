#!/bin/bash

sed -i -e "s/\/var\/app\/ondeck/\/var\/app\/current/" app/cache/$SYMFONY_ENV/*.php
