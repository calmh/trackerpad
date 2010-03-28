#!/bin/sh

uncrustify -l oc -c uncrustify.cfg --replace --no-backup Classes/*.[mh] Libraries/*.[mh] Tests/*.[mh] main.m 

