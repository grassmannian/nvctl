(import spork/path)

(defn resolve-home [path]
  (def home (os/getenv "HOME"))
  (string/replace "~" home path))

(defn resolve-base-dir []
  (or 
    (os/getenv "NVCTL_DIR")
    (try 
      (resolve-home (string/trim (slurp (resolve-home  "~/.config/nvctl/.nvctl"))))
      ([err] nil))
    (resolve-home "~/scripts")))

(defn run 
  "does something, an even better function"
  [args]
  (let [script-path (path/join (resolve-base-dir) ;args)]
    (print script-path)
    (os/execute ["bash" script-path] :p)))
