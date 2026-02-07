(import spork/path)

(defn resolve-base-dir []
  (def home (os/getenv "HOME"))
  (or 
    (os/getenv "NVCTL_DIR")
    (try 
      (string/trim (slurp (path/join home ".config/nvctl/.nvctl"))) 
      ([err] nil))
    (path/join home "scripts")))

(defn run 
  "does something, an even better function"
  [args]
  (let [script-path (path/join (resolve-base-dir) ;args)]
    (print script-path)
    (os/execute ["bash" script-path] :p)))
