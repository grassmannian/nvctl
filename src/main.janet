(import ./nvctl)

(defn main [& args]
  (nvctl/run (slice args 1)))
