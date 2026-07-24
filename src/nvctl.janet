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

(defn resolve-child
  "Resolve `arg` within `base`, match exact name first, then file `arg.*`
  returns child path or nil"
  [base arg]
  (def exact (path/join base arg))
  (if (os/stat exact :mode)
    exact
    (when (= :directory (os/stat base :mode))
      (def prefix (string arg "."))
      (when-let [name (find |(string/has-prefix? prefix $) (sort (os/dir base)))]
        (path/join base name)))))

(defn build-command [base args]
  (if-let [next-arg (first args)
           child (resolve-child base next-arg)]
    (build-command child (drop 1 args))
    [base ;args]))

(defn run
  [args]
  (if (= "--help" (last args))
    (find-help-command (first (build-command (resolve-base-dir) (slice args 0 -2))))
    (os/execute (build-command (resolve-base-dir) args) :p)))
