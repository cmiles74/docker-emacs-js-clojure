(ns cmiles74.hello
  (:gen-class))

(defn main
  [& args]
  (println "Hello World!"))

(defn -main
  [& args]
  (apply main args))
