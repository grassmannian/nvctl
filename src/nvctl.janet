#!/usr/bin/env janet

(import spork)

(let [args (dyn :args)]
  (if (empty? args)
    (spork/exit 1 "Usage: nv <command> [args...]")
    (let [script-path (string/join args "/")]
      (os/execute [script-path] :inherit true))))