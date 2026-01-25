(declare-project
  :name "nvctl"
  :description "a cli for my scripts?"

  # Optional urls to git repositories that contain required artifacts.
  :dependencies ["https://github.com/janet-lang/spork.git"])

(declare-executable
 :name "nv"
 :entry "src/main.janet")
