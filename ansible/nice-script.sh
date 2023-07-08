#!/bin/bash

mount | awk '{print $1, $3}'
