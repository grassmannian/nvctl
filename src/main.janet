# This will be printed when you run `jpm build`
(import ./nvctl)

(print "build time!")
(defn main
  [& args]
  # You can also get command-line arguments through (dyn :args)
  (print "args: " ;(interpose ", " args)))
