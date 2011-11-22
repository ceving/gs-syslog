#!/usr/bin/env gsi-script

(##include "syslog#.scm")

(define (main . args)
  (openlog "gambit" LOG_PID LOG_USER)
  (syslog LOG_INFO "Hello, World!")
  (closelog))
