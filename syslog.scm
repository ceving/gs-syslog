(##namespace ("syslog#"))
(##include "~~lib/gambit#.scm")
(##include "syslog#.scm")

(c-declare "#include <syslog.h>")
(c-declare "#include <string.h>")
(c-declare "#include <stdlib.h>")

(define-macro (c-define-ints . names)
  `(begin
     ,@(map (lambda (name)
              `(define ,name
                 ((c-lambda () int
                    ,(string-append "___result = "
                                    (symbol->string name) ";")))))
            names)))

(c-define-ints
 ;; option
 LOG_CONS
 LOG_NDELAY
 LOG_NOWAIT
 LOG_ODELAY
 LOG_PERROR
 LOG_PID
 ;; facility
 LOG_AUTHPRIV
 LOG_CRON
 LOG_DAEMON
 LOG_FTP
 LOG_KERN
 LOG_LOCAL0
 LOG_LOCAL1
 LOG_LOCAL2
 LOG_LOCAL3
 LOG_LOCAL4
 LOG_LOCAL5
 LOG_LOCAL6
 LOG_LOCAL7
 LOG_LPR
 LOG_MAIL
 LOG_NEWS
 LOG_SYSLOG
 LOG_USER
 LOG_UUCP
 ;; level
 LOG_EMERG
 LOG_ALERT
 LOG_CRIT
 LOG_ERR
 LOG_WARNING
 LOG_NOTICE
 LOG_INFO
 LOG_DEBUG)

(define openlog
  (c-lambda (nonnull-char-string int int) void
#<<C-END
static char *ident = NULL;
if (ident) free (ident);
ident = strdup (___arg1);
openlog (ident, ___arg2, ___arg3);
C-END
))

(define syslog (c-lambda (int nonnull-char-string) void "syslog"))
(define closelog (c-lambda () void "closelog"))
