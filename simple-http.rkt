#|
Little program that awaits an incoming TCP connection
and returns with a little message.

  [aryehh@nixos:~/Development/simple-rkt-http]$ racket simple-http.rkt
  Listening on 49777
  ^Z
  [1]+  Stopped                 racket simple-http.rkt
  
  [aryehh@nixos:~/Development/simple-rkt-http]$ bg
  [1]+ racket simple-http.rkt &
  
  [aryehh@nixos:~/Development/simple-rkt-http]$ telnet localhost 49777
  Trying ::1...
  Connected to localhost.
  Escape character is '^]'.
  "oh, brave new world with such people in it!"
  Connection closed by foreign host.
|#

#lang racket

; Require Racket's TCP library
(require racket/tcp)

; Create a listener that binds a random port
(define listener (tcp-listen 0)) ; 0 means "bind an available port"

; Method that gives the port a listener has bound 
; ... i.e. a light wrapper for tcp-addresses
(define (tcp-listener-port-number listener)
  (match/values
    (tcp-addresses listener #t)
    [(_ port-number _ _) port-number]))

; Print the port that we have bound
(let ([port-number (tcp-listener-port-number listener)])
  (displayln
    (string-append "Listening on " (number->string port-number))))

; Await a client, send a message, and close the connection to the client
(let loop ()
  (let-values ([(in-port out-port) (tcp-accept listener)])
    (writeln
      "oh, brave new world with such people in it!"
      out-port)
    (flush-output out-port)
    (close-output-port out-port))
  (loop))

