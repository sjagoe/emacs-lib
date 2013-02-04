;; (setq jabber-username "sjagoe" ;; notice: leave off the @gmail.com
;;       jabber-server "enthought.com"     ;; this is a part of your user ID, not a part of the server you will connect to.
;;       jabber-network-server "talk.google.com"  ;; this is the actual server to connect to
;;       jabber-port 5223
;;       jabber-connection-type 'ssl)

(setq jabber-account-list
      '(("invalid-email" 
         (:network-server . "talk.google.com")
         (:connection-type . ssl)
         (:port . 5223)
         (:password . "invalid-password"))))

(provide 'sj-jabber)
