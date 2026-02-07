(defn run 
  "does something, an even better function"
  [args]
  (let [script-path (string/join args "/")]
    (os/execute ["bash" script-path] :p))
  ())
