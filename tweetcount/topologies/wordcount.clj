(ns wordcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetcount [options]
   [
    ;; spout configuration
    {"sentence-spout" (python-spout-spec
          options
          "spouts.sentences.Sentences"
          ["sentence"]
          ) }
    ;; bolt configuration 1
    {"parse-bolt" (python-bolt-spec
          options
          {"sentence-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["valid_word"]
          :p 2
          )
    ;; bolt configuration 2
    "count-bolt" (python-bolt-spec
          options
          {"parse-bolt" :shuffle}
          "bolts.tweetcounter.TweetCounter"
          ["word" "count"]
          :p 2
          )
    }
  ]
)
