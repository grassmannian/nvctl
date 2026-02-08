(declare-project
  :name "nvctl"
  :description "a cli for my scripts?"
  :version "1.0.0"
  :dependencies ["https://github.com/janet-lang/spork.git"])

(declare-executable
 :name "nvctl"
 :entry "src/main.janet"
 :install true)
