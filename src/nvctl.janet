(defn- main [& args]
  (if-let [[_ subcommand script] (dyn :args)]
    (let [script-path (string/join [subcommand script] "/")]
      (os/execute ["bash" script-path] :p))
    (eprintf "Usage: nvctl <subcommand> <script>")))
