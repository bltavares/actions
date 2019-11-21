(ns rewrite-projectclj
  (:require [rewrite-clj.zip :as z]))

(defn only-plugins-and-cljfmt
  [sexpr]
  (let [[defproj proj version & {:keys [plugins cljfmt test-paths]}] sexpr]
    (list
     defproj proj version
     :plugins    (filterv (fn [[k v]] (= k 'lein-cljfmt)) plugins)
     :cljfmt     cljfmt
     :test-paths test-paths)))

(-> (z/of-file "/github/workspace/project.clj")
    (z/edit only-plugins-and-cljfmt)
    z/root-string
    ((partial spit "/github/workspace/project.clj")))
