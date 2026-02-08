(import spork/path)

(defn resolve-home [path]
  (def home (os/getenv "HOME"))
  (string/replace "~" home path))

(defn resolve-base-dir []
  (or
    (os/getenv "NVCTL_DIR")
    (try
      (resolve-home (string/trim (slurp (resolve-home "~/.config/nvctl/.nvctl"))))
      ([err] nil))
    (resolve-home "~/scripts")))

(defn find-help-command [path]
  (with [f (file/open path :r) file/close]
    (if-let [line (find |(string/has-prefix? "##" $) (file/lines f))]
      (print line))))

(defn run
  "does something, an even better function"
  [args]
  (if (= "--help" (last args))
    (find-help-command (path/join (resolve-base-dir) ;(slice args 0 -2)))
    (let [script-path (path/join (resolve-base-dir) ;args)]
      (print script-path)
      (os/execute [script-path] :p))))
