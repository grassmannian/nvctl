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

(defn build-command [base args]
  (if-let [next-arg (first args)
           test-path (path/join base next-arg)
           exists (os/stat test-path :mode)]
    (build-command test-path (drop 1 args))
    [base ;args]))

(defn run
  [args]
  (if (= "--help" (last args))
    (find-help-command (path/join (resolve-base-dir) ;(slice args 0 -2)))
    (os/execute (build-command (resolve-base-dir) args) :p)))
